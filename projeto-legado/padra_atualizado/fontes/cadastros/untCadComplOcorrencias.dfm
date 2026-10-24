inherited frmCadComplOcorrencias: TfrmCadComplOcorrencias
  Height = 387
  Caption = 'Cadastro de Complementos das Ocorr'#234'ncias'
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 317
    Height = 25
    ExplicitTop = 317
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Height = 21
      ExplicitTop = 2
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        ExplicitWidth = 83
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        ExplicitLeft = 83
        ExplicitWidth = 83
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        ExplicitLeft = 166
        ExplicitWidth = 83
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        ExplicitLeft = 249
        ExplicitWidth = 83
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        ExplicitLeft = 332
        ExplicitWidth = 83
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        ExplicitLeft = 415
        ExplicitWidth = 83
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 500
      Width = 73
      Height = 20
      ExplicitLeft = 500
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 342
    ExplicitTop = 342
    inherited pnlNomeForm: TPanel
      Left = 384
      Width = 201
      ExplicitLeft = 384
      ExplicitWidth = 201
    end
    inherited pnlInfo: TPanel
      Width = 384
      ExplicitWidth = 384
    end
  end
  inherited pgcDados: TPageControl
    Height = 317
    ExplicitHeight = 317
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 285
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 317
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 63
      Top = 25
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 47
      Top = 48
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 4
      Top = 73
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Ocorr'#234'ncia:'
    end
    object Label4: TLabel
      Left = 7
      Top = 94
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mensagem Padr'#227'o:'
    end
    object lblAlterarCatLead: TLabel
      Left = 10
      Top = 290
      Width = 213
      Height = 14
      Alignment = taRightJustify
      Caption = 'Alterar Categoria do Prospecto para LEAD ?'
    end
    object clrLblAltCatLead: TColorLabel
      Left = 270
      Top = 290
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 22
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COC_CODCOC'
      DataSource = dtsCadCoc
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesCoc: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 45
      Width = 381
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COC_DESCOC'
      DataSource = dtsCadCoc
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipOco: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 68
      Width = 55
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COC_CODTOC'
      DataSource = dtsCadCoc
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnKeyPress = dbeTipOcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesTipOco: TEditFocus
      Left = 155
      Top = 68
      Width = 326
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbmMsgPad: TDBMemoFocus
      Left = 100
      Top = 93
      Width = 381
      Height = 191
      DataField = 'COC_MSGPAD'
      DataSource = dtsCadCoc
      ScrollBars = ssVertical
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeCatLea: TDBEditFocus
      Tag = 99
      Left = 229
      Top = 286
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COC_ALTLEA'
      DataSource = dtsCadCoc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsCadCoc: TDataSource
    Left = 248
  end
end
