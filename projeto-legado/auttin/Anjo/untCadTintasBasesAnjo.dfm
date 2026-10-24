inherited frmCadTintasBasesAnjo: TfrmCadTintasBasesAnjo
  Caption = 'frmCadTintasBasesAnjo'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlCampos: TPanel
    inherited lblBase: TLabel
      Left = 144
      ExplicitLeft = 144
    end
    object lblProdKey: TLabel [9]
      Left = 253
      Top = 20
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Prod. Key:'
    end
    object lblSubKey: TLabel [10]
      Left = 370
      Top = 20
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Prod. Key:'
    end
    inherited dbeBase: TDBEditFocus
      Left = 176
      Width = 65
      ExplicitLeft = 176
      ExplicitWidth = 65
    end
    inherited dbeCodigo: TDBEditFocus
      Width = 65
      ExplicitWidth = 65
    end
    inherited dbeDescricao: TDBEditFocus
      TabOrder = 7
    end
    inherited dbeItemBase: TDBEditFocus
      TabOrder = 8
    end
    inherited dbeCodUni: TDBEditFocus
      TabOrder = 4
    end
    inherited dbePrecoCusto: TDBEditFocus
      TabOrder = 10
    end
    inherited dbePrecoVenda: TDBEditFocus
      TabOrder = 12
    end
    inherited dbeMargem: TDBEditFocus
      TabOrder = 11
    end
    inherited edtDesItemBase: TEditFocus
      TabOrder = 9
    end
    inherited edtDesUni: TEditFocus
      TabOrder = 5
    end
    inherited edtSigUni: TEditFocus
      TabOrder = 6
    end
    object dbeProdKey: TDBEditFocus
      Tag = 99
      Left = 307
      Top = 16
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSubKey: TDBEditFocus
      Tag = 99
      Left = 424
      Top = 16
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    inherited pnlInfo: TPanel
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 108
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 487
    Top = 108
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 104
  end
end
