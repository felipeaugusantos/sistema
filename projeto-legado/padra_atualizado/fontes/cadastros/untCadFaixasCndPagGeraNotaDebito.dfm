inherited frmCadFaixasCndPagGeraNotaDebito: TfrmCadFaixasCndPagGeraNotaDebito
  Width = 700
  Height = 164
  Caption = 
    'Cadastro de Faixas de Condi'#231#245'es de Pagamento para Gera'#231#227'o de Not' +
    'a de D'#233'bito  - AG'
  ExplicitWidth = 700
  ExplicitHeight = 164
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 94
    Width = 694
    Height = 25
    TabOrder = 1
    ExplicitTop = 94
    ExplicitWidth = 694
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 690
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 690
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 622
      Width = 63
      Height = 20
      ExplicitLeft = 622
      ExplicitWidth = 63
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 509
    Top = 160
    Width = 0
    Align = alNone
    TabOrder = 3
    ExplicitLeft = 509
    ExplicitTop = 160
    ExplicitWidth = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  inherited pnlStatus: TPanel
    Top = 119
    Width = 694
    TabOrder = 2
    ExplicitTop = 119
    ExplicitWidth = 694
    inherited pnlNomeForm: TPanel
      Left = 512
      Width = 182
      ExplicitLeft = 512
      ExplicitWidth = 182
    end
    inherited pnlInfo: TPanel
      Width = 512
      ExplicitWidth = 512
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 694
    Height = 94
    Align = alClient
    TabOrder = 0
    object Label12: TLabel
      Left = 14
      Top = 16
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Inicial:'
    end
    object Label1: TLabel
      Left = 164
      Top = 16
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Final:'
    end
    object lblCndPag: TLabel
      Left = 10
      Top = 42
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pagto:'
    end
    object lblCodEmp: TLabel
      Left = 26
      Top = 63
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 158
      Top = 34
      Width = 527
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      ReadOnly = True
      TabOrder = 3
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtValIni: TDBEditFocus
      Tag = 99
      Left = 73
      Top = 10
      Width = 83
      Height = 22
      DataField = 'FAI_VALINI'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtValFin: TDBEditFocus
      Tag = 99
      Left = 217
      Top = 10
      Width = 66
      Height = 22
      DataField = 'FAI_VALFIN'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtCodCnd: TDBEditFocus
      Tag = 99
      Left = 73
      Top = 34
      Width = 83
      Height = 22
      DataField = 'FAI_CODCND'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 73
      Top = 58
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FAI_CODEMP'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
      OnChamaCadastro = dbeCodEmpChamaCadastro
    end
    object edtNomEmp: TEditFocus
      Left = 158
      Top = 58
      Width = 308
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 0
  end
end
