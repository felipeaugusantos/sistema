inherited frmCadMotFinOco: TfrmCadMotFinOco
  Left = 319
  Top = 465
  Width = 535
  Height = 257
  Caption = 'Cadastro de Motivo Finaliza'#231#227'o de Ocorr'#234'ncia'
  ExplicitWidth = 535
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 187
    Width = 529
    Height = 25
    ExplicitTop = 166
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 525
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      Width = 73
      Height = 20
      ExplicitLeft = 446
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 212
    Width = 529
    ExplicitTop = 191
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 322
      Width = 207
      ExplicitLeft = 322
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 322
      ExplicitWidth = 322
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 187
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 166
    object lblCodigo: TLabel
      Left = 27
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 11
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblTrocarCat: TLabel
      Left = 9
      Top = 155
      Width = 195
      Height = 14
      Alignment = taRightJustify
      Caption = 'Trocar Categoria no Cad. Prospecto por:'
    end
    object Label1: TLabel
      Left = 11
      Top = 63
      Width = 173
      Height = 14
      Caption = 'Atribuir o Status do Prospecto para:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 12
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_CODIGO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 35
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbcUsaStatus_D: TDBCheckBox
      Left = 11
      Top = 83
      Width = 454
      Height = 17
      Caption = 
        ' D - Prospecto que j'#225' foi contactado e n'#227'o '#233' pass'#237'vel de venda, ' +
        'por qualquer motivo'
      DataField = 'MOT_STAT_D'
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dbcUsaStatus_DClick
    end
    object dbcUsaStatus_I: TDBCheckBox
      Tag = 1
      Left = 11
      Top = 100
      Width = 424
      Height = 32
      Caption = 
        ' I - Prospecto que ainda n'#227'o foi contactado ou foi contactado e ' +
        #233' pass'#237'vel de venda,  mas n'#227'o conseguiu iniciar trabalho com ele'
      DataField = 'MOT_STAT_I'
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      WordWrap = True
      OnClick = dbcUsaStatus_IClick
    end
    object dbeCodCat: TDBEditFocus
      Tag = 99
      Left = 210
      Top = 155
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_CODCAT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      OnKeyPress = dbeCodCatKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesCat: TEditFocus
      Tag = 99
      Left = 275
      Top = 155
      Width = 240
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbcUsaStatus_A: TDBCheckBox
      Tag = 1
      Left = 11
      Top = 132
      Width = 454
      Height = 17
      Caption = 
        ' A - Prospecto que j'#225' foi contactado, '#233' pass'#237'vel de venda, e est' +
        #225' sendo trabalhado'
      DataField = 'MOT_STAT_A'
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dbcUsaStatus_AClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 60
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 100
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 104
  end
end
