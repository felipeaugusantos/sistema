inherited frmFatExpServicosConferencia: TfrmFatExpServicosConferencia
  Width = 487
  Height = 382
  Caption = 'Expedi'#231#227'o de Servi'#231'os - Confer'#234'ncia'
  Position = poScreenCenter
  ExplicitWidth = 487
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 311
    Width = 481
    Height = 26
    TabOrder = 1
    ExplicitTop = 311
    ExplicitWidth = 481
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 102
      Width = 300
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 477
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 402
      Top = 2
      Align = alRight
      ExplicitLeft = 398
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 100
      Height = 22
      Align = alLeft
      Caption = '[F10] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
      ExplicitLeft = 6
      ExplicitTop = 3
    end
  end
  object lblFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 481
    Height = 311
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 309
    object gpbConf: TGroupBox
      Left = 1
      Top = 260
      Width = 479
      Height = 50
      Align = alBottom
      Caption = 'Confer'#234'ncia'
      TabOrder = 1
      ExplicitTop = 258
      DesignSize = (
        479
        50)
      object Label3: TLabel
        Left = 6
        Top = 21
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
      end
      object Label1: TLabel
        Left = 176
        Top = 21
        Width = 29
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtde.:'
      end
      object Label2: TLabel
        Left = 388
        Top = 10
        Width = 24
        Height = 12
        Anchors = [akTop, akBottom]
        Caption = 'Sa'#237'da'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 388
        Top = 23
        Width = 32
        Height = 12
        Anchors = [akTop, akBottom]
        Caption = 'Entrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 389
        Top = 36
        Width = 41
        Height = 12
        Anchors = [akTop, akBottom]
        Caption = 'Conferido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 52
        Top = 18
        Width = 119
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtQtdIte: TEditFocus
        Tag = 99
        Left = 211
        Top = 18
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 5
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object lblLegBlue: TPanel
        Left = 372
        Top = 37
        Width = 10
        Height = 10
        Anchors = [akTop, akBottom]
        BevelOuter = bvNone
        Color = clBlue
        ParentBackground = False
        TabOrder = 4
        StyleElements = []
      end
      object Panel1: TPanel
        Left = 372
        Top = 24
        Width = 10
        Height = 10
        Anchors = [akTop, akBottom]
        BevelOuter = bvNone
        Color = clGreen
        ParentBackground = False
        TabOrder = 3
        StyleElements = []
      end
      object Panel2: TPanel
        Left = 372
        Top = 11
        Width = 10
        Height = 10
        Anchors = [akTop, akBottom]
        BevelOuter = bvNone
        Color = clYellow
        ParentBackground = False
        TabOrder = 0
        StyleElements = []
      end
    end
    object dbgPedidos: TDBGridCitel
      Left = 1
      Top = 1
      Width = 479
      Height = 259
      Align = alClient
      DataSource = dtsItens
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgPedidosDrawColumnCell
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DESITE'
          Title.Caption = 'Produto'
          Width = 250
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SIGUNI'
          Title.Alignment = taCenter
          Title.Caption = 'Un.'
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde. Exp'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde. Conf.'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ENTSAI'
          Title.Alignment = taCenter
          Title.Caption = 'E/S'
          Width = 24
          Visible = True
        end>
    end
  end
  inherited pnlStatus: TPanel
    Top = 337
    Width = 481
    TabOrder = 2
    ExplicitTop = 337
    ExplicitWidth = 481
    inherited pnlNomeForm: TPanel
      Left = 310
      TabOrder = 1
      ExplicitLeft = 310
    end
    inherited pnlInfo: TPanel
      Width = 310
      TabOrder = 0
      ExplicitWidth = 310
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 802
    Top = 180
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 794
    Top = 146
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 428
    Top = 74
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Visible = False
      Size = 5
    end
    object cdsItensBAREMB: TStringField
      DisplayWidth = 20
      FieldName = 'BAREMB'
      Visible = False
    end
    object cdsItensCODBAR: TStringField
      DisplayWidth = 20
      FieldName = 'CODBAR'
      Visible = False
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 76
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 5
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensQTDCON: TFloatField
      FieldName = 'QTDCON'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensENTSAI: TStringField
      FieldName = 'ENTSAI'
      Size = 1
    end
    object cdsItensNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Visible = False
      Size = 12
    end
    object cdsItensCODEMP: TStringField
      FieldName = 'CODEMP'
      Visible = False
      Size = 3
    end
    object cdsItensCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsItensSEQINC: TIntegerField
      FieldName = 'SEQINC'
      Visible = False
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 378
    Top = 74
  end
end
