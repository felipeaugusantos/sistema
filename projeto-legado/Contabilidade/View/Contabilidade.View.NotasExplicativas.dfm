inherited frmNotasExplicativas: TfrmNotasExplicativas
  Width = 800
  Height = 600
  Caption = 'Notas Explicativas'
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 530
    Width = 794
    Height = 25
    ExplicitTop = 530
    ExplicitWidth = 794
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 790
      Height = 21
      ExplicitWidth = 790
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 78
        ExplicitWidth = 78
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 720
      Width = 71
      ExplicitLeft = 720
      ExplicitWidth = 71
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      Width = 171
      ExplicitLeft = 623
      ExplicitWidth = 171
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited pgcDados: TPageControl
    Width = 794
    Height = 530
    TabOrder = 3
    ExplicitWidth = 794
    ExplicitHeight = 530
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 498
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 530
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 271
      Top = 12
      Width = 100
      Height = 14
      Caption = 'Data Final Apura'#231#227'o:'
    end
    object Label1: TLabel
      Left = 30
      Top = 38
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
    end
    object Label3: TLabel
      Left = 32
      Top = 64
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nota Explicativa:'
    end
    object Label4: TLabel
      Left = 11
      Top = 12
      Width = 104
      Height = 14
      Caption = 'Data Inicial Apura'#231#227'o:'
    end
    object dbeCodCon: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 35
      Width = 156
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EXP_CODCON'
      DataSource = dtsNotExp
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbeCodConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaFin: TDBEditFocus
      Tag = 99
      Left = 377
      Top = 8
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EXP_DTAFIN'
      DataSource = dtsNotExp
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNotExp: TDBMemoFocus
      Tag = 99
      Left = 117
      Top = 63
      Width = 664
      Height = 456
      DataField = 'EXP_NOTEXP'
      DataSource = dtsNotExp
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtNomCon: TEditFocus
      Tag = 50
      Left = 279
      Top = 35
      Width = 502
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeAutoincrem: TDBEditFocus
      Left = 660
      Top = 7
      Width = 121
      Height = 22
      DataField = 'AUTOINCREM'
      DataSource = dtsNotExp
      TabOrder = 5
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaIni: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 8
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EXP_DTAINI'
      DataSource = dtsNotExp
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 8
  end
  object dtsNotExp: TDataSource
    Left = 320
    Top = 228
  end
end
