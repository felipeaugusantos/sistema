inherited frmFiltroEtiFuncionarios: TfrmFiltroEtiFuncionarios
  Width = 362
  Height = 159
  ActiveControl = edtNomIni
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 362
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 115
    Width = 356
    ExplicitTop = 115
    ExplicitWidth = 356
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 356
    ExplicitTop = 115
    ExplicitWidth = 356
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
    end
  end
  inherited pgcDados: TPageControl
    Width = 356
    Height = 115
    ExplicitWidth = 356
    ExplicitHeight = 115
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 348
      ExplicitHeight = 83
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 356
    Height = 115
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 22
      Top = 13
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Inicial:'
    end
    object Label2: TLabel
      Left = 25
      Top = 36
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Final:'
    end
    object Label10: TLabel
      Left = 11
      Top = 89
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Etiquetas:'
    end
    object edtNomIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 9
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFin: TEditFocus
      Tag = 99
      Left = 84
      Top = 32
      Width = 256
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 84
      Top = 82
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object chkMosFil: TCheckBox
      Left = 84
      Top = 60
      Width = 261
      Height = 17
      Caption = 'Mostrar apenas registros que satisfazem o filtro'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
end
