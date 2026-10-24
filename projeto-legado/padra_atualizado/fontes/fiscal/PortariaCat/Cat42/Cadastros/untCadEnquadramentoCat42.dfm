inherited frmCadEnquadramentoCat42: TfrmCadEnquadramentoCat42
  Width = 617
  Height = 207
  Caption = 'Cadastro de Configura'#231#227'o de Enquadramento por Cfop'
  ExplicitWidth = 617
  ExplicitHeight = 207
  PixelsPerInch = 96
  TextHeight = 14
  object Label270: TLabel [0]
    Left = 8
    Top = 92
    Width = 32
    Height = 14
    Caption = 'Cfops:'
  end
  object Label1: TLabel [1]
    Left = 8
    Top = 49
    Width = 22
    Height = 14
    Caption = 'CST:'
  end
  object Label247: TLabel [2]
    Left = 8
    Top = 8
    Width = 78
    Height = 14
    Caption = 'Enquadramento:'
  end
  inherited pnlBotoes: TPanel
    Top = 134
    Width = 611
    TabOrder = 2
    ExplicitTop = 134
    ExplicitWidth = 611
    inherited btnSair: TBitBtn
      Left = 528
      ExplicitLeft = 528
    end
    inherited btnPesquisar: TBitBtn
      OnClick = btnPesquisarClick
    end
    inherited btnGravar: TBitBtn
      TabOrder = 7
    end
    object btnEnquadramentoVsPeriodoApuracao: TBitBtn
      Left = 443
      Top = 4
      Width = 83
      Height = 20
      Hint = 'Enquadramento vs Per'#237'odo de Apura'#231#227'o'
      Caption = 'Enq. vs Per. Ap.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnEnquadramentoVsPeriodoApuracaoClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 162
    Width = 611
    TabOrder = 3
    ExplicitTop = 162
    ExplicitWidth = 611
    inherited pnlNomeForm: TPanel
      Left = 440
      ExplicitLeft = 440
    end
    inherited pnlInfo: TPanel
      Width = 440
      ExplicitWidth = 440
      inherited btnShowTrace: TSpeedButton
        Left = 438
        ExplicitLeft = 438
      end
      inherited btnHideTrace: TSpeedButton
        Left = 438
        ExplicitLeft = 438
      end
    end
  end
  object mskCfopEnquadramento: TMaskEditFocus [5]
    Tag = 99
    Left = 8
    Top = 107
    Width = 584
    Height = 22
    EditMask = 
      '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
      '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
      '9-9999-9999-9999-;0;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 145
    TabOrder = 1
    Text = ''
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskCstEnquadramento: TMaskEditFocus [6]
    Tag = 99
    Left = 8
    Top = 64
    Width = 329
    Height = 22
    EditMask = '99-99-99-99-99-99-99-99-99-99-99-99-99-99-99-99-99-99-99-99-;0;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 60
    TabOrder = 0
    Text = ''
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object lcbDescricaoEnquadramento: TDBLookupComboBox [7]
    Tag = 99
    Left = 8
    Top = 25
    Width = 329
    Height = 22
    DataField = 'ENQ_CODENQ'
    DataSource = dtsTabela
    KeyField = 'AUTOINCREM'
    ListField = 'ENQ_DESENQ'
    ListSource = dtsDescricaoEnquadramento
    TabOrder = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 32
  end
  object dtsTabela: TDataSource
    OnStateChange = dtsTabelaStateChange
    Left = 375
    Top = 20
  end
  object dtsDescricaoEnquadramento: TDataSource
    Left = 496
    Top = 21
  end
end
