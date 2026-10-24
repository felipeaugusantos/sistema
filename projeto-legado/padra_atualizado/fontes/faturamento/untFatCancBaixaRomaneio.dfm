inherited frmFatCancBaixaRomaneio: TfrmFatCancBaixaRomaneio
  Left = 172
  Top = 210
  Width = 798
  Height = 478
  BorderIcons = [biSystemMenu]
  Caption = 'Cancela Baixa de Romaneio'
  Position = poOwnerFormCenter
  ExplicitTop = -43
  ExplicitWidth = 798
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 404
    Width = 792
    Height = 29
    ExplicitTop = 384
    ExplicitWidth = 792
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 788
      Height = 25
      ExplicitWidth = 788
      ExplicitHeight = 25
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 689
      Width = 100
      ExplicitLeft = 689
      ExplicitWidth = 100
    end
  end
  inherited pnlStatus: TPanel
    Top = 433
    Width = 792
    ExplicitTop = 413
    ExplicitWidth = 792
    inherited pnlNomeForm: TPanel
      Left = 621
      ExplicitLeft = 621
    end
    inherited pnlInfo: TPanel
      Width = 621
      ExplicitWidth = 621
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 792
    Height = 80
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblRomaneio: TLabel
      Left = 8
      Top = 2
      Width = 47
      Height = 14
      Caption = 'Romaneio'
    end
    object lblMotorista: TLabel
      Left = 8
      Top = 38
      Width = 44
      Height = 14
      Caption = 'Motorista'
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 7
      Top = 15
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 72
      Top = 51
      Width = 340
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 8
      Top = 51
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  object dbgDocumentos: TDBGridCitel [3]
    Left = 0
    Top = 80
    Width = 792
    Height = 259
    Align = alClient
    DataSource = dtsDocumentos
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDocumentosDrawColumnCell
    OnKeyDown = dbgDocumentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_ROMIMP'
        Title.Caption = 'Impress.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Data Entrada'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        Title.Caption = 'Cidade'
        Width = 139
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODVEN'
        Title.Caption = 'Vend.'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRA_NOMTRA'
        Title.Caption = 'Transportadora'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 78
        Visible = True
      end>
  end
  object pnlInfAdd: TPanel [4]
    Left = 0
    Top = 339
    Width = 792
    Height = 65
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 343
    object lbl1: TLabel
      Left = 6
      Top = 19
      Width = 67
      Height = 14
      Caption = 'Recebido por:'
    end
    object lbl2: TLabel
      Left = 18
      Top = 43
      Width = 52
      Height = 14
      Caption = 'Ajudantes:'
    end
    object edtNomRec: TEditFocus
      Left = 77
      Top = 11
      Width = 346
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj1: TEditFocus
      Tag = 99
      Left = 77
      Top = 35
      Width = 170
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj2: TEditFocus
      Tag = 99
      Left = 253
      Top = 35
      Width = 170
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj4: TEditFocus
      Tag = 99
      Left = 605
      Top = 35
      Width = 170
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj3: TEditFocus
      Tag = 99
      Left = 429
      Top = 35
      Width = 170
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 6
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 6
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 548
    Top = 6
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentos'
    AfterScroll = cdsDocumentosAfterScroll
    Left = 515
    Top = 6
  end
  object dspDocumentos: TUniDataSetProvider
    DataSet = qryDocumentos
    Options = []
    Left = 482
    Top = 6
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.LongStrings = False
    Constraints = <>
    Left = 449
    Top = 6
  end
end
