inherited frmCadCondLinGruGlobal: TfrmCadCondLinGruGlobal
  Width = 793
  Height = 226
  Caption = 'Altera'#231#227'o GLOBAL de Desconto M'#225'ximo Linha/Grupo de Produtos'
  ExplicitWidth = 793
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 155
    Width = 787
    TabOrder = 1
    ExplicitTop = 155
    ExplicitWidth = 787
    inherited FlwBotoes: TFlowPanel
      Width = 783
      ExplicitWidth = 783
    end
    inherited btnSair: TBitBtnLocked
      Left = 704
      ExplicitLeft = 704
    end
  end
  inherited pnlStatus: TPanel
    Top = 181
    Width = 787
    TabOrder = 2
    ExplicitTop = 181
    ExplicitWidth = 787
    inherited pnlNomeForm: TPanel
      Left = 616
      ExplicitLeft = 616
    end
    inherited pnlInfo: TPanel
      Width = 616
      ExplicitWidth = 616
    end
  end
  object pnlItem: TPanel [2]
    Left = 0
    Top = 0
    Width = 787
    Height = 155
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 66
      Top = 46
      Width = 96
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Linha/Grupo:'
    end
    object Label3: TLabel
      Left = 14
      Top = 72
      Width = 148
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Gerente J'#250'nior:'
    end
    object Label4: TLabel
      Left = 535
      Top = 72
      Width = 140
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Vendedo J'#250'nior:'
    end
    object lbl1: TLabel
      Left = 43
      Top = 22
      Width = 119
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Condi'#231#227'o de Pagto:'
    end
    object Label2: TLabel
      Left = 260
      Top = 72
      Width = 167
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Sub-Gerente J'#250'nior:'
    end
    object Label5: TLabel
      Left = 14
      Top = 96
      Width = 148
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Gerente Master:'
    end
    object Label6: TLabel
      Left = 260
      Top = 96
      Width = 167
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Sub-Gerente Master:'
    end
    object Label7: TLabel
      Left = 528
      Top = 96
      Width = 147
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Vendedor Master:'
    end
    object lblLegenda: TLabel
      Left = 23
      Top = 128
      Width = 465
      Height = 14
      Caption = 
        '* Ap'#243's confirma'#231#227'o, todas as informa'#231#245'es presentes nos campos de' +
        ' desconto ser'#227'o alterados.'
    end
    object edtCodCnd: TEditFocus
      Tag = 99
      Left = 168
      Top = 19
      Width = 96
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtCodLinhaGru: TEditFocus
      Tag = 99
      Left = 168
      Top = 43
      Width = 96
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      TabOrder = 2
      OnKeyPress = edtCodLinhaGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesMaxGerJun: TEditFocus
      Left = 168
      Top = 68
      Width = 96
      Height = 22
      Alignment = taRightJustify
      TabOrder = 4
      Text = '0,00'
      OnExit = edtDesMaxGerJunExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesMaxGerMas: TEditFocus
      Left = 168
      Top = 93
      Width = 96
      Height = 22
      Alignment = taRightJustify
      TabOrder = 7
      Text = '0,00'
      OnExit = edtDesMaxGerMasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesMaxSubGerJun: TEditFocus
      Left = 433
      Top = 68
      Width = 96
      Height = 22
      Alignment = taRightJustify
      TabOrder = 5
      Text = '0,00'
      OnExit = edtDesMaxSubGerJunExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesMaxSubGerMas: TEditFocus
      Left = 433
      Top = 93
      Width = 96
      Height = 22
      Alignment = taRightJustify
      TabOrder = 8
      Text = '0,00'
      OnExit = edtDesMaxSubGerMasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesMaxVenJun: TEditFocus
      Left = 679
      Top = 68
      Width = 96
      Height = 22
      Alignment = taRightJustify
      TabOrder = 6
      Text = '0,00'
      OnExit = edtDesMaxVenJunExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesMaxVenMas: TEditFocus
      Left = 679
      Top = 93
      Width = 96
      Height = 22
      Alignment = taRightJustify
      TabOrder = 9
      Text = '0,00'
      OnExit = edtDesMaxVenMasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesLinhaGru: TEditFocus
      Left = 266
      Top = 43
      Width = 509
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCnd: TEditFocus
      Left = 266
      Top = 19
      Width = 509
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 408
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 392
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 672
    Top = 392
  end
  object UniQuery1: TUniQuery
    Constraints = <>
    Left = 16
    Top = 24
  end
end
