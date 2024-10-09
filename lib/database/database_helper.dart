import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';
import 'package:frontend_inventary_mobile/models/inventoryRequest.dart';
import 'package:frontend_inventary_mobile/models/productOrder.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    print("Ruta de la base de datos: $path"); // Verificar la ruta de la base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creando base de datos y tablas...'); // Confirmar creación

        // Crear tabla productos
        await db.execute(
          'CREATE TABLE productos(id INTEGER PRIMARY KEY, idLocalizacion TEXT, sku TEXT, name TEXT, total INTEGER, id_company INTEGER, id_user TEXT, created_at TEXT, updated_at TEXT)',
        );
        print('Tabla productos creada exitosamente'); // Confirmar creación de tabla

        // Crear tabla de solicitudes de inventario (inventory_requests)
        await db.execute(
          'CREATE TABLE inventory_requests(id INTEGER PRIMARY KEY AUTOINCREMENT, id_area TEXT, fecha_hora TEXT, id_user TEXT)',
        );
        print('Tabla inventory_requests creada exitosamente'); // Confirmar creación de tabla

        // Crear tabla de relación de productos en las solicitudes (product_orders)
        await db.execute(
          'CREATE TABLE product_orders(id INTEGER PRIMARY KEY AUTOINCREMENT, id_inventory_request INTEGER, id_product INTEGER, id_user_order INTEGER, FOREIGN KEY(id_inventory_request) REFERENCES inventory_requests(id))',
        );
        print('Tabla product_orders creada exitosamente'); // Confirmar creación de tabla
      },
    );
  }

  // Métodos para la tabla `productos`
  Future<void> insertProduct(Producto product) async {
    final db = await database;
    await db.insert(
      'productos',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Producto insertado: ${product.name}'); // Confirmar inserción de producto
  }

  Future<List<Producto>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('productos');
    print('Productos obtenidos de la base de datos: $maps'); // Verificar productos obtenidos
    return List.generate(maps.length, (i) {
      return Producto.fromJson(maps[i]);
    });
  }

  Future<void> deleteAllProducts() async {
    final db = await database;
    await db.delete('productos');
    print('Todos los productos eliminados de la base de datos'); // Confirmar eliminación de productos
  }

  // Métodos para la tabla `inventory_requests`
  Future<void> insertInventoryRequest(InventoryRequest request) async {
    final db = await database;
    // Insertar la solicitud de inventario y obtener el ID generado
    int idRequest = await db.insert(
      'inventory_requests',
      {
        'id_area': request.idArea,
        'fecha_hora': request.fechaHora,
        'id_user': request.idUser,
      },
    );
    print('Solicitud de inventario insertada con ID: $idRequest'); // Confirmar inserción

    // Insertar los productos asociados a la solicitud de inventario
    for (var product in request.products) {
      await db.insert(
        'product_orders',
        {
          'id_inventory_request': idRequest,
          'id_product': product.idProduct,
          'id_user_order': product.idUserOrder,
        },
      );
    }
    print('Productos insertados en la solicitud de inventario con ID: $idRequest'); // Confirmar inserción
  }

  Future<List<InventoryRequest>> getInventoryRequests() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('inventory_requests');
    print('Solicitudes de inventario obtenidas de la base de datos: $maps'); // Verificar solicitudes obtenidas

    List<InventoryRequest> requests = [];

    for (var map in maps) {
      // Obtener los productos asociados a cada solicitud de inventario
      List<ProductOrder> products = await getProductOrders(map['id']);
      requests.add(
        InventoryRequest(
          idArea: map['id_area'],
          fechaHora: map['fecha_hora'],
          idUser: map['id_user'],
          products: products,
        ),
      );
    }
    print('Solicitudes de inventario completas: $requests'); // Confirmar solicitudes completas
    return requests;
  }

  Future<void> deleteAllInventoryRequests() async {
    final db = await database;
    await db.delete('inventory_requests');
    await db.delete('product_orders');
    print('Todas las solicitudes de inventario y productos relacionados eliminados'); // Confirmar eliminación
  }

  // Métodos para la tabla `product_orders`
  Future<List<ProductOrder>> getProductOrders(int idRequest) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'product_orders',
      where: 'id_inventory_request = ?',
      whereArgs: [idRequest],
    );
    print('Productos de la solicitud de inventario con ID $idRequest: $maps'); // Verificar productos asociados
    return List.generate(maps.length, (i) {
      return ProductOrder(
        idProduct: maps[i]['id_product'],
        idUserOrder: maps[i]['id_user_order'],
      );
    });
  }
}
