inherited frmCadAdenFatSer: TfrmCadAdenFatSer
  Width = 568
  Height = 299
  Caption = 'Cadastro de Adendos para Faturamento de Servi'#231'os'
  ExplicitWidth = 568
  ExplicitHeight = 299
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 229
    Width = 562
    Height = 25
    ExplicitTop = 229
    ExplicitWidth = 562
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 558
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 558
      inherited btnIncluir: TBitBtnLocked
        Width = 80
        ExplicitWidth = 80
      end
      inherited btnGravar: TBitBtnLocked
        Left = 80
        Width = 80
        ExplicitLeft = 80
        ExplicitWidth = 80
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 160
        Width = 80
        ExplicitLeft = 160
        ExplicitWidth = 80
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 240
        Width = 80
        ExplicitLeft = 240
        ExplicitWidth = 80
      end
      inherited btnCancela: TBitBtnLocked
        Left = 320
        Width = 80
        ExplicitLeft = 320
        ExplicitWidth = 80
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 400
        Width = 80
        ExplicitLeft = 400
        ExplicitWidth = 80
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 482
      Width = 71
      Height = 20
      ExplicitLeft = 482
      ExplicitWidth = 71
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 8
    Top = -100
    Width = 1
    Height = 1
    Align = alNone
    ExplicitLeft = 8
    ExplicitTop = -100
    ExplicitWidth = 1
    ExplicitHeight = 1
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 562
    Height = 229
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 226
    object lblCodigo: TLabel
      Left = 10
      Top = 12
      Width = 68
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
      Layout = tlBottom
    end
    object lblDescricao: TLabel
      Left = 10
      Top = 41
      Width = 68
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
      Layout = tlBottom
    end
    object lblTexto: TLabel
      Left = 9
      Top = 68
      Width = 69
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Texto:'
      Layout = tlBottom
    end
    object dbeCodAde: TDBEditFocus
      Tag = 99
      Left = 81
      Top = 9
      Width = 99
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ADE_CODADE'
      DataSource = dtsCadAde
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 81
      Top = 38
      Width = 469
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADE_DESCRI'
      DataSource = dtsCadAde
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object mmoTexto: TDBMemoFocus
      Tag = 99
      Left = 81
      Top = 69
      Width = 469
      Height = 145
      DataField = 'ADE_TEXTO_'
      DataSource = dtsCadAde
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited pnlStatus: TPanel
    Top = 254
    Width = 562
    ExplicitTop = 254
    ExplicitWidth = 562
    inherited pnlNomeForm: TPanel
      Left = 400
      Width = 162
      ExplicitLeft = 400
      ExplicitWidth = 162
    end
    inherited pnlInfo: TPanel
      Width = 400
      ExplicitWidth = 215
    end
  end
  object dtsCadAde: TDataSource
    Left = 352
  end
end
