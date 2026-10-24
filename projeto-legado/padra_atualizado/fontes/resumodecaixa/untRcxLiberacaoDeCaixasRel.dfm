object frmRcxLiberacaoDeCaixasRel: TfrmRcxLiberacaoDeCaixasRel
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'frmRcxLiberacaoDeCaixasRel'
  ClientHeight = 280
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxLiberacaoAjuda: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44657.634828634260000000
    ReportOptions.LastChange = 44657.634828634260000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 80
    Top = 40
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxLiberacaoAjuda.rlbProcedimentos
        object memTitulo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 11.338590000000000000
          Width = 710.551640000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Autentica'#231#227'o de Transfer'#234'ncias')
          ParentFont = False
        end
      end
      object rlbProcedimentos: TfrxChild
        FillType = ftBrush
        Height = 449.764070000000000000
        Top = 98.267780000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 15.118120000000000000
          Top = 22.677180000000000000
          Width = 691.653990000000000000
          Height = 404.409710000000000000
          Memo.UTF8W = (
            'A autentica'#231#227'o de transfer'#234'ncias funciona da seguinte forma:'
            ''
            
              '  -Em cada fechamento, s'#227'o exibidas as modalidades das transfer'#234 +
              'ncias realizadas, al'#233'm de exibir o valor da diverg'#234'ncia do fecha' +
              'mento de caixa (caso exista).'
            '  '
            '  -Cada tipo de modalidade ter'#225' uma forma de funcionamento.'
            
              '  1) Modalidades vinculadas: (CART'#195'O, CHEQUE A VISTA E CHEQUE PR' +
              #201')'
            
              '     -Para realizar o "Aceite" da modalidade, o operador dever'#225' ' +
              'clicar no bot'#227'o "...", onde deve selecionar os documentos da mod' +
              'alidade. Nesse momento poder'#225' realizar ajustes nos documentos.'
            
              '     -Ap'#243's realizado o aceite, a mocimenta'#231#227'o banc'#225'ria da modali' +
              'dade e os documentos vinculados ser'#227'o liberados.'
            '  '
            '  2) Modalidades (DINHEIRO E ORDEM DE PAGAMENTO)'
            
              '    -Ao realizar o "Aceite", ser'#225' exibido para selecionar um por' +
              'tador. Se o portador for o mesmo da transfer'#234'ncia, o sistema rea' +
              'lizar'#225' apenas a libera'#231#227'o da movimenta'#231#227'o banc'#225'ria. Caso seja di' +
              'ferente, al'#233'm de liberar a movimenta'#231#227'o banc'#225'ria, o sistema lan'#231 +
              'ar'#225' um d'#233'bito no portador da transfer'#234'ncia e um cr'#233'dito no novo ' +
              'portador.'
            
              '    -Ao realizar a "Recusa", ser'#225' exibido para digitar um motivo' +
              ' para a recusa. O sistema ir'#225' voltar o valor da modalidade ao ca' +
              'ixa e realizar'#225' um d'#233'bito no portador da transfer'#234'ncia.'
            ''
            '  3) DIVERG'#202'NCIA'
            
              '    -Ao realizar o "Aceite", ser'#225' exibido para selecionar um por' +
              'tador. O sistema lan'#231'ar'#225' o valor na movimenta'#231#227'o banc'#225'ria do por' +
              'tador selecionado..'
            
              '    -Ao realizar a "Recusa", ser'#225' exibido para digitar um motivo' +
              ' para a recusa. O sistema ir'#225' lan'#231'ar o valor ao caixa.'
            
              '    -Ao realizar o "Ajuste", o sistema ir'#225' ajustar o valor da di' +
              'verg'#234'ncia no caixa. '
            ''
            
              'O fechamento poder'#225' ser liberado apenas ap'#243's todas as modalidade' +
              's e diverg'#234'ncia estiverem com o "Status" diferente de "PENDENTE"' +
              '.')
        end
      end
    end
  end
end
