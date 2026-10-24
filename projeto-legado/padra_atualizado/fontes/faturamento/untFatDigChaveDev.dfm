inherited frmFatDigChaveDev: TfrmFatDigChaveDev
  Width = 368
  Height = 359
  Caption = 'Chave NFe '#224' ser devolvida'
  ExplicitWidth = 368
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 288
    Width = 362
    TabOrder = 3
    ExplicitTop = 288
    ExplicitWidth = 362
    inherited FlwBotoes: TFlowPanel
      Width = 358
      ExplicitWidth = 358
    end
    inherited btnSair: TBitBtnLocked
      Left = 280
      ExplicitLeft = 280
    end
  end
  object pnlButtons: TPanel [2]
    Left = 0
    Top = 0
    Width = 362
    Height = 46
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object rdgDocVen: TRadioGroup
      Left = 9
      Top = 1
      Width = 343
      Height = 39
      Caption = 'Doc. de Venda'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Nota Fiscal'
        'Cupom Fiscal'
        'NFCe')
      TabOrder = 0
      OnClick = rdgDocVenClick
    end
  end
  object pnlNF: TPanel [3]
    Left = 0
    Top = 46
    Width = 362
    Height = 106
    Align = alTop
    ParentColor = True
    TabOrder = 1
    object lblTituloNF: TLabel
      Left = 8
      Top = 6
      Width = 194
      Height = 14
      Caption = 'Chave NFe (Nota Fiscal '#224' ser devolvida)'
    end
    object lblObsNF: TLabel
      Left = 8
      Top = 54
      Width = 344
      Height = 42
      Caption = 
        '**S'#243' '#233' permitido informar somente uma chave de acesso.'#13#10'**A chav' +
        'e da NFe deve referenciar a todos os itens informados'#13#10'nesta dev' +
        'olu'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object edtChave: TEditFocus
      Tag = 99
      Left = 8
      Top = 25
      Width = 344
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 46
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 46
      TipoTexto = ttNumerico
    end
  end
  object pnlIF: TPanel [4]
    Left = 0
    Top = 152
    Width = 362
    Height = 131
    Align = alTop
    ParentColor = True
    TabOrder = 2
    ExplicitLeft = -1
    object Label3: TLabel
      Left = 26
      Top = 10
      Width = 41
      Height = 14
      Caption = 'N'#186' COO:'
    end
    object Label4: TLabel
      Left = 24
      Top = 36
      Width = 43
      Height = 14
      Caption = 'N'#186' S'#233'rie:'
    end
    object Label5: TLabel
      Left = 7
      Top = 62
      Width = 58
      Height = 14
      Caption = 'C'#243'digo ECF:'
    end
    object lblObsIF: TLabel
      Left = 8
      Top = 86
      Width = 342
      Height = 42
      Caption = 
        '**S'#243' '#233' permitido informar somente um Cupom de ref'#234'ncia. **Os dad' +
        'os acima do Cupom deve referenciar a todos os itens informados n' +
        'esta devolu'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object edtNumCOO: TEditFocus
      Tag = 99
      Left = 71
      Top = 7
      Width = 121
      Height = 22
      Alignment = taRightJustify
      MaxLength = 9
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 9
      TipoTexto = ttNumerico
    end
    object edtNumSer: TEditFocus
      Tag = 99
      Left = 71
      Top = 33
      Width = 281
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodNSU: TEditFocus
      Tag = 99
      Left = 71
      Top = 59
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 314
    Width = 362
    TabOrder = 4
    ExplicitTop = 314
    ExplicitWidth = 362
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 272
  end
end
