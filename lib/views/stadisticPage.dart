import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend_inventary_mobile/components/footerComponent.dart';
import 'package:frontend_inventary_mobile/components/headerSettingsComponent.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: HeaderSettingsComponent(
          title: 'Estadísticas',
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatisticCard(
                title: 'Valor total del inventario',
                value1Title: 'Total de inversión',
                value1: '\$000.00',
                value2Title: 'Total de productos',
                value2: '12346',
                value3Title: 'Impuestos',
                value3: '\$000.00',
              ),
              const SizedBox(height: 16),
              _buildTimeSelector(),
              const SizedBox(height: 16),
              _buildBarChart(), // Agregar gráfico de barras aquí
              const SizedBox(height: 16),
              _buildStatisticCard(
                title: 'Compras',
                value1Title: 'Total de inversión',
                value1: '\$000.00',
                value2Title: 'Total de productos',
                value2: '12346',
                value3Title: 'Impuestos',
                value3: '\$000.00',
              ),
              const SizedBox(height: 16),
              _buildStatisticCard(
                title: 'Ventas',
                value1Title: 'Total de inversión',
                value1: '\$000.00',
                value2Title: 'Total de productos',
                value2: '12346',
                value3Title: 'Impuestos',
                value3: '\$000.00',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterComponent(),
    );
  }

  Widget _buildStatisticCard({
    required String title,
    required String value1Title,
    required String value1,
    required String value2Title,
    required String value2,
    required String value3Title,
    required String value3,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatisticRow(value1Title, value1),
              ),
              Expanded(
                child: _buildStatisticRow(value2Title, value2),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatisticRow(value3Title, value3),
              ),
              const Expanded(
                child: SizedBox(), // Empty space for alignment
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
          ),
          child: const Text(
            'Día',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
          ),
          child: const Text(
            'Mes',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
          ),
          child: const Text(
            'Año',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(toY: 100, color: Colors.blue),
                  BarChartRodData(toY: 90, color: Colors.purple),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(toY: 75, color: Colors.blue),
                  BarChartRodData(toY: 65, color: Colors.purple),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(toY: 50, color: Colors.blue),
                  BarChartRodData(toY: 45, color: Colors.purple),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(toY: 25, color: Colors.blue),
                  BarChartRodData(toY: 20, color: Colors.purple),
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(toY: 0, color: Colors.blue),
                  BarChartRodData(toY: 5, color: Colors.purple),
                ],
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 42,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('0M');
                      case 25:
                        return Text('25M');
                      case 50:
                        return Text('50M');
                      case 75:
                        return Text('75M');
                      case 100:
                        return Text('100M');
                      default:
                        return Container();
                    }
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('Jan');
                      case 1:
                        return Text('Feb');
                      case 2:
                        return Text('Mar');
                      case 3:
                        return Text('Apr');
                      case 4:
                        return Text('May');
                      default:
                        return Container();
                    }
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            gridData: FlGridData(
              show: false, // Desactiva las líneas de la cuadrícula
            ),
          ),
        ),
      ),
    );
  }

}
