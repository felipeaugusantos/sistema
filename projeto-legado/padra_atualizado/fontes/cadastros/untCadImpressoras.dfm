inherited frmCadImpressoras: TfrmCadImpressoras
  Width = 526
  Height = 160
  Caption = 'Cadastro de Impressoras'
  ExplicitWidth = 526
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 520
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ExplicitTop = 83
    ExplicitWidth = 520
    inherited FlwBotoes: TFlowPanel
      Left = 4
      Top = 4
      Width = 445
      Height = 20
      Align = alLeft
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitWidth = 445
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        Align = alLeft
        ExplicitWidth = 71
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        Align = alLeft
        ExplicitLeft = 71
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 70
        Align = alLeft
        ExplicitLeft = 142
        ExplicitWidth = 70
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 212
        Width = 70
        Align = alLeft
        ExplicitLeft = 212
        ExplicitWidth = 70
      end
      inherited btnCancela: TBitBtnLocked
        Left = 282
        Align = alLeft
        ExplicitLeft = 282
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 354
        Width = 75
        Align = alLeft
        ExplicitLeft = 354
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      Top = 4
      Width = 75
      Height = 20
      Align = alRight
      ExplicitLeft = 439
      ExplicitTop = 4
      ExplicitWidth = 75
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 520
    Height = 87
    ExplicitWidth = 520
    ExplicitHeight = 83
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 512
      ExplicitHeight = 51
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 520
    Height = 87
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 83
    object Label1: TLabel
      Left = 18
      Top = 13
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 24
      Top = 36
      Width = 30
      Height = 14
      Caption = 'Nome:'
    end
    object lblTipImp: TLabel
      Left = 31
      Top = 60
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object dbeCodImp: TDBEditFocus
      Tag = 99
      Left = 56
      Top = 9
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IMP_CODIMP'
      DataSource = dtsCadImp
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomImp: TDBEditFocus
      Tag = 99
      Left = 56
      Top = 32
      Width = 397
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IMP_NOMIMP'
      DataSource = dtsCadImp
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cmbTipImp: TComboBoxFocus
      Tag = 99
      Left = 56
      Top = 55
      Width = 201
      Height = 22
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 2
      Text = 'JATO DE TINTA/LASER'
      Items.Strings = (
        'MATRICIAL'
        'JATO DE TINTA/LASER')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 520
    ExplicitTop = 111
    ExplicitWidth = 520
    inherited pnlNomeForm: TPanel
      Left = 173
      ExplicitLeft = 173
    end
    inherited pnlInfo: TPanel
      Width = 173
      ExplicitWidth = 173
    end
  end
  object dtsCadImp: TDataSource
    Left = 344
  end
end
