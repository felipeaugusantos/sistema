inherited frmCadPlanoContasPorCst: TfrmCadPlanoContasPorCst
  Width = 593
  Height = 144
  Caption = 'Cadastro de Plano Cont'#225'bil (Vinculado CST)'
  OnDestroy = FormDestroy
  ExplicitWidth = 593
  ExplicitHeight = 144
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 71
    Width = 587
    ExplicitTop = 95
    ExplicitWidth = 587
    inherited FlwBotoes: TFlowPanel
      Width = 583
      ExplicitTop = 2
      ExplicitWidth = 583
    end
  end
  inherited pnlStatus: TPanel
    Top = 99
    Width = 587
    ExplicitTop = 123
    ExplicitWidth = 587
    inherited pnlNomeForm: TPanel
      Left = 240
      ExplicitLeft = 240
    end
    inherited pnlInfo: TPanel
      Width = 240
      ExplicitWidth = 240
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 587
    Height = 71
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 95
    object lbl1: TLabel
      Left = 6
      Top = 5
      Width = 45
      Height = 14
      Caption = 'Cod. CST'
    end
    object lblTipo: TLabel
      Left = 72
      Top = 5
      Width = 67
      Height = 14
      Caption = 'Plano Cont'#225'bil'
    end
    object Label1: TLabel
      Left = 229
      Top = 5
      Width = 20
      Height = 14
      Caption = 'Tipo'
    end
  end
  inherited pgcDados: TPageControl
    Width = 587
    Height = 71
    ActivePage = nil
    ExplicitWidth = 587
    ExplicitHeight = 95
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 579
      ExplicitHeight = 63
    end
  end
  object pnlCentral: TPanel [4]
    Left = 0
    Top = 0
    Width = 587
    Height = 71
    Align = alClient
    Color = 16770261
    TabOrder = 4
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 579
    ExplicitHeight = 63
    object Label2: TLabel
      Left = 14
      Top = 13
      Width = 45
      Height = 14
      Caption = 'Cod. CST'
    end
    object Label3: TLabel
      Left = 80
      Top = 13
      Width = 67
      Height = 14
      Caption = 'Plano Cont'#225'bil'
    end
    object Label4: TLabel
      Left = 237
      Top = 13
      Width = 20
      Height = 14
      Caption = 'Tipo'
    end
    object edtCodCst: TDBEditFocus
      Left = 13
      Top = 27
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PLA_CODCST'
      DataSource = dtsCstPla
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
    object edtPlanoContabil: TDBEditFocus
      Tag = 99
      Left = 79
      Top = 27
      Width = 151
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PLA_CONCON'
      DataSource = dtsCstPla
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 1
      OnKeyPress = edtPlanoContabilKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cmbTipoCst: TComboBoxFocus
      Left = 236
      Top = 27
      Width = 76
      Height = 22
      Style = csDropDownList
      CharCase = ecUpperCase
      ItemIndex = 2
      TabOrder = 2
      Text = 'H'#205'BRIDO'
      Items.Strings = (
        'PIS'
        'COFINS'
        'H'#205'BRIDO')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 48
  end
  object dtsCstPla: TDataSource
    Left = 480
    Top = 4
  end
end
