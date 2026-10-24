inherited frmDominioSistemasProcessarDocumentos: TfrmDominioSistemasProcessarDocumentos
  Width = 526
  Height = 389
  Caption = 'Integra'#231#227'o Dom'#237'nio Sistemas'
  ExplicitWidth = 526
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 22
    Top = 16
    Width = 39
    Height = 14
    Alignment = taRightJustify
    Caption = 'Per'#237'odo:'
  end
  object Label3: TLabel [1]
    Left = 38
    Top = 68
    Width = 23
    Height = 14
    Alignment = taRightJustify
    Caption = 'Tipo:'
  end
  object lblCodEmp: TLabel [2]
    Left = 18
    Top = 43
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  inherited pnlBotoes: TPanel
    Top = 318
    Width = 520
    TabOrder = 4
    ExplicitTop = 318
    ExplicitWidth = 520
    inherited FlwBotoes: TFlowPanel
      Width = 516
      ExplicitWidth = 516
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
      object btnConsulta: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 198
        Height = 22
        Caption = 'C&onsultar Documentos Processados'
        TabOrder = 1
        OnClick = btnConsultaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      ExplicitLeft = 440
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 520
    TabOrder = 5
    ExplicitTop = 344
    ExplicitWidth = 520
    inherited pnlNomeForm: TPanel
      Left = 349
      ExplicitLeft = 349
    end
    inherited pnlInfo: TPanel
      Width = 349
      ExplicitWidth = 349
    end
  end
  object mskDtaIni: TMaskEditFocus [5]
    Tag = 99
    Left = 72
    Top = 12
    Width = 69
    Height = 22
    EditMask = '99/99/9999'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object mskDtaFin: TMaskEditFocus [6]
    Tag = 99
    Left = 148
    Top = 12
    Width = 72
    Height = 22
    EditMask = '99/99/9999'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  object cklListaTipos: TCheckListBox [7]
    Left = 72
    Top = 68
    Width = 438
    Height = 177
    Hint = 
      'Somente os tipos configurados nos par'#226'metros da contabilidade es' +
      'tar'#227'o habilitados para sele'#231#227'o.'
    Columns = 2
    ItemHeight = 14
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object gbInfo: TGroupBox [8]
    Left = 2
    Top = 251
    Width = 508
    Height = 59
    Caption = 'Informa'#231#227'o Licen'#231'a'
    TabOrder = 6
    object lblContabilidade: TLabel
      Left = 7
      Top = 19
      Width = 74
      Height = 14
      Caption = 'lblContabilidade'
    end
    object lblCliente: TLabel
      Left = 7
      Top = 37
      Width = 42
      Height = 14
      Caption = 'lblCliente'
    end
  end
  object edtCodEmp: TEditFocus [9]
    Tag = 99
    Left = 72
    Top = 40
    Width = 57
    Height = 22
    Hint = 'Tecle / para selecionar varias empresas'
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [10]
    Left = 132
    Top = 40
    Width = 378
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 7
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 112
  end
end
