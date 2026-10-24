inherited frmPedeEmpOrigem: TfrmPedeEmpOrigem
  Width = 745
  Height = 649
  BorderStyle = bsSizeable
  Caption = 'Informe a quantidade a transferir por empresa'
  ExplicitWidth = 745
  ExplicitHeight = 649
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 566
    Width = 729
    TabOrder = 3
    ExplicitTop = 566
    ExplicitWidth = 729
    inherited btnSair: TBitBtnLocked
      Left = 647
      ExplicitLeft = 647
    end
      inherited btnConfirma: TBitBtnLocked
      Left = 4
        Width = 117
        Caption = '[ F10 ] Confirma'
      ExplicitLeft = 4
        ExplicitWidth = 117
      end
    end
  inherited pnlStatus: TPanel
    Top = 594
    Width = 729
    TabOrder = 4
    ExplicitTop = 594
    ExplicitWidth = 729
    inherited pnlNomeForm: TPanel
      Left = 558
      ExplicitLeft = 558
    end
    inherited pnlInfo: TPanel
      Width = 558
      ExplicitWidth = 558
    end
  end
  object pnlItem: TPanel [3]
    Left = 0
    Top = 0
    Width = 729
    Height = 73
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object Label7: TLabel
      Left = 73
      Top = 45
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 29
      Top = 22
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 116
      Top = 41
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 206
      Top = 41
      Width = 514
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 116
      Top = 18
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 206
      Top = 18
      Width = 514
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgEmpresas: TcxGridCitel [4]
    Left = 0
    Top = 73
    Width = 729
    Height = 389
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 97
    ExplicitHeight = 365
    object cxvEmpresas: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxvEmpresasQTDITE
        end
        item
          Kind = skSum
          Column = cxvEmpresasSALDIS
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvEmpresasCODEMP: TcxGridDBColumn
        Caption = 'Emp. Origem'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 92
      end
      object cxvEmpresasNOMEMP: TcxGridDBColumn
        Caption = 'Nome da Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Options.Editing = False
        Width = 289
      end
      object cxvEmpresasESTMIN: TcxGridDBColumn
        Caption = 'Estoque M'#237'nimo'
        DataBinding.FieldName = 'ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxvEmpresasSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDIS_ORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 107
      end
      object cxvEmpresasQTDITE: TcxGridDBColumn
        Caption = 'Quantidade a transferir'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 124
      end
      object cxvEmpresasSALUSU: TcxGridDBColumn
        DataBinding.FieldName = 'SALUSU'
        Visible = False
        SortIndex = 0
        SortOrder = soDescending
      end
    end
    object cxgEmpresasLevel1: TcxGridLevel
      GridView = cxvEmpresas
    end
  end
  object pnlRodape: TPanel [5]
    Left = 0
    Top = 462
    Width = 729
    Height = 104
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    ExplicitTop = 459
    object lblQtdSug: TLabel
      Left = 351
      Top = 76
      Width = 107
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade Sugest'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 344
      Top = 22
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade Requisi'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 17
      Top = 76
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transferir + Comprar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 36
      Top = 22
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total a Transferir:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 10
      Top = 46
      Width = 111
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade a Comprar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 336
      Top = 14
      Width = 2
      Height = 81
    end
    object Shape2: TShape
      Left = 64
      Top = 63
      Width = 149
      Height = 1
    end
    object Label8: TLabel
      Left = 215
      Top = 75
      Width = 94
      Height = 14
      Caption = 'em unidades venda'
    end
    object Label1: TLabel
      Left = 215
      Top = 21
      Width = 94
      Height = 14
      Caption = 'em unidades venda'
    end
    object lblEmbalagem: TLabel
      Left = 215
      Top = 45
      Width = 115
      Height = 14
      AutoSize = False
      Caption = 'em unidades venda'
    end
    object edtQtdSug: TEditFocus
      Tag = 99
      Left = 461
      Top = 68
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtQtdReq: TEditFocus
      Tag = 99
      Left = 461
      Top = 14
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtQtdTot: TEditFocus
      Tag = 99
      Left = 124
      Top = 68
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtQtdTra: TEditFocus
      Tag = 99
      Left = 124
      Top = 14
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 124
      Top = 38
      Width = 89
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = clWhite
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object rdgAtendida: TRadioGroup
      Left = 558
      Top = 13
      Width = 162
      Height = 73
      Caption = 'Requisi'#231#227'o ser'#225' atendida por'
      Items.Strings = (
        'Transfer'#234'ncia'
        'Pedido de Compra')
      TabOrder = 1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 184
  end
end
