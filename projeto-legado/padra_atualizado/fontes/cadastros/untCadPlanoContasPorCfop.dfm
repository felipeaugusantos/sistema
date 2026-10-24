inherited frmCadPlanoContasPorCfop: TfrmCadPlanoContasPorCfop
  Width = 658
  Height = 472
  Caption = 'Cadastro de Plano Cont'#225'bil (Vinculado Classifica'#231#227'o fiscal)'
  OnDestroy = FormDestroy
  ExplicitWidth = 658
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 399
    Width = 652
    ExplicitTop = 67
    ExplicitWidth = 652
    inherited FlwBotoes: TFlowPanel
      Width = 648
      ExplicitWidth = 648
    end
    inherited btnSair: TBitBtnLocked
      Left = 569
      ExplicitLeft = 569
    end
  end
  inherited pnlStatus: TPanel
    Top = 427
    Width = 652
    ExplicitTop = 95
    ExplicitWidth = 652
    inherited pnlNomeForm: TPanel
      Left = 305
      ExplicitLeft = 305
    end
    inherited pnlInfo: TPanel
      Width = 305
      ExplicitWidth = 305
    end
  end
  object dbgrdCfopPla: TDBGridCitel [2]
    Left = 0
    Top = 57
    Width = 652
    Height = 342
    Align = alClient
    DataSource = dtsCfoPlaGrid
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'PLA_CODCFO'
        Title.Caption = 'Class. Fiscal'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLA_CONCIN'
        Title.Caption = 'Plano Cont'#225'bil (Com incid'#234'ncia)'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLA_CONSIN'
        Title.Caption = 'Plano Cont'#225'bil (Sem incid'#234'ncia)'
        Width = 170
        Visible = True
      end>
  end
  inherited pgcDados: TPageControl
    Top = 57
    Width = 652
    Height = 342
    ActivePage = nil
    ExplicitWidth = 652
    ExplicitHeight = 67
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitTop = 6
      ExplicitWidth = 644
      ExplicitHeight = 77
    end
  end
  object pnlCentral: TPanel [4]
    Left = 0
    Top = 0
    Width = 652
    Height = 57
    Align = alTop
    Color = 16770261
    TabOrder = 4
    object lbl1: TLabel
      Left = 11
      Top = 10
      Width = 61
      Height = 14
      Caption = 'Class. Fiscal'
    end
    object lblTipo: TLabel
      Left = 77
      Top = 10
      Width = 150
      Height = 14
      Caption = 'Plano Cont'#225'bil (Com incid'#234'ncia)'
    end
    object Label1: TLabel
      Left = 233
      Top = 10
      Width = 150
      Height = 14
      Caption = 'Plano Cont'#225'bil (Sem incid'#234'ncia)'
    end
    object edtCodClaFis: TDBEditFocus
      Left = 11
      Top = 24
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PLA_CODCFO'
      DataSource = dtsCfoPla
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtPcComIncidencia: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 24
      Width = 151
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PLA_CONCIN'
      DataSource = dtsCfoPla
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 1
      OnKeyPress = edtPcComIncidenciaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtPcSemIncidencia: TDBEditFocus
      Tag = 99
      Left = 233
      Top = 24
      Width = 152
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PLA_CONSIN'
      DataSource = dtsCfoPla
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 2
      OnKeyPress = edtPcSemIncidenciaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesClaFis: TEditFocus
      Left = 400
      Top = 24
      Width = 238
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 57
    Width = 652
    Height = 342
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 5
    object grdCfoPla: TDBGridCitel
      Left = 1
      Top = 1
      Width = 650
      Height = 340
      Align = alClient
      DataSource = dtsCfoPlaGrid
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyPress = grdCfoPlaKeyPress
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'PLA_CODCFO'
          Title.Caption = 'Class. Fiscal'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLA_CONCIN'
          Title.Caption = 'Plano Cont'#225'bil (Com incid'#234'ncia)'
          Width = 170
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLA_CONSIN'
          Title.Caption = 'Plano Cont'#225'bil (Sem incid'#234'ncia)'
          Width = 170
          Visible = True
        end>
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 40
  end
  object dtsCfoPlaGrid: TDataSource
    Left = 552
    Top = 160
  end
  object dtsCfoPla: TDataSource
    Left = 552
    Top = 112
  end
end
