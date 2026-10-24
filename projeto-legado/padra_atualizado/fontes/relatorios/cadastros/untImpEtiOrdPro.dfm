inherited frmImpEtiOrdPro: TfrmImpEtiOrdPro
  Width = 816
  Height = 477
  Caption = 'Etiquetas - Ordem de Produ'#231#227'o'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 816
  ExplicitHeight = 477
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 404
    Width = 810
    ExplicitTop = 404
    ExplicitWidth = 810
    inherited btnSair: TBitBtnLocked
      Left = 727
      TabOrder = 2
      ExplicitLeft = 727
    end
    object btnLazer: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 96
      Height = 22
      Caption = '&Imprimir'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000030000000C000000120000001400000014000000150000
        0015000000140000000D00000003000000000000000000000000000000000000
        00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
        78FFBE8978FF876356C30000000B000000000000000000000000000000030000
        000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
        E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
        42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
        72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
        6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
        76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
        71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
        35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
        78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
        DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
        7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
        32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
        86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
        42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
        8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
        DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
        84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
        E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
        2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
        E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
        0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
        E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
        00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
        EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
        00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
        FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
        000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
        91FFCDA391FF98786BC100000004000000000000000000000000}
      TabOrder = 0
      OnClick = btnLazerClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 432
    Width = 810
    ExplicitTop = 432
    ExplicitWidth = 810
    inherited pnlNomeForm: TPanel
      Left = 639
      ExplicitLeft = 639
    end
    inherited pnlInfo: TPanel
      Width = 639
      ExplicitWidth = 639
    end
  end
  object cxgMovPro: TcxGridCitel [3]
    Left = 0
    Top = 169
    Width = 810
    Height = 235
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgMovProTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxGridCitelColumnQTDETI: TcxGridDBColumn
        Caption = 'Qtde. Etiqueta'
        DataBinding.FieldName = 'QTDETI'
        Width = 73
      end
      object cxGridCitelColumnQTDPRO: TcxGridDBColumn
        Caption = 'Qtde. Produzida'
        DataBinding.FieldName = 'QTDPRO'
        Width = 95
      end
      object cxGridCitelColumnCODPRO: TcxGridDBColumn
        Caption = 'C'#243'digo OP'
        DataBinding.FieldName = 'CODPRO'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnSIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnDTACAD: TcxGridDBColumn
        Caption = 'Dt.Cadastro'
        DataBinding.FieldName = 'DTACAD'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnDTAPRO: TcxGridDBColumn
        Caption = 'Dt.Previs'#227'o'
        DataBinding.FieldName = 'DTAPRO'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnDTABAI: TcxGridDBColumn
        Caption = 'Dt. Baixa'
        DataBinding.FieldName = 'DTABAI'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnQTDAPR: TcxGridDBColumn
        Caption = 'Qtde. a Produzir'
        DataBinding.FieldName = 'QTDAPR'
        Options.Editing = False
        Options.Focusing = False
        Width = 84
      end
      object cxGridCitelColumnNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGridCitelColumnESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
        Options.Editing = False
        Options.Focusing = False
      end
    end
    object cxgMovProLevel1: TcxGridLevel
      GridView = cxgMovProTableView
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 810
    Height = 169
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object lblProduto: TLabel
      Left = 7
      Top = 89
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 43
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 90
      Top = 43
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 124
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label3: TLabel
      Left = 90
      Top = 124
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object Label1: TLabel
      Left = 7
      Top = 3
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Ordem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSerie: TLabel
      Left = 135
      Top = 124
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 7
      Top = 101
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPro: TEditFocus
      Left = 72
      Top = 101
      Width = 353
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 59
      Width = 77
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 90
      Top = 59
      Width = 78
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object rdgTipDta: TRadioGroup
      Left = 174
      Top = 43
      Width = 251
      Height = 38
      Caption = 'Data'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Cadastro'
        'Previs'#227'o'
        'Baixa')
      TabOrder = 3
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 7
      Top = 140
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 89
      Top = 140
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtOrdPro: TEditFocus
      Tag = 99
      Left = 7
      Top = 18
      Width = 115
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtOrdProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 134
      Top = 140
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
    Top = 92
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 428
    Top = 4
  end
end
