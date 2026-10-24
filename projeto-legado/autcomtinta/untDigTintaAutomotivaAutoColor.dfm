inherited frmDigTintaAutomotivaAutoColor: TfrmDigTintaAutomotivaAutoColor
  Left = 463
  Top = 127
  Height = 382
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 310
    ExplicitTop = 310
  end
  inherited pnlStatus: TPanel
    Top = 338
    ExplicitTop = 338
  end
  inherited pnlGeral: TPanel
    Height = 310
    ExplicitHeight = 310
    inherited pnlCabecalho: TPanel
      inherited rdgModoVenda: TRadioGroup
        OnEnter = rdgModoVendaEnter
        OnExit = rdgModoVendaExit
      end
    end
    inherited pnlAdicional: TPanel
      Visible = True
      object Label7: TLabel [1]
        Left = 352
        Top = 8
        Width = 54
        Height = 14
        Caption = 'Diluente %:'
      end
      object edtDil: TEditFocus
        Left = 352
        Top = 24
        Width = 70
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        Text = '0'
        OnExit = edtDilExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    inherited pnlRodape: TPanel
      Height = 22
      ExplicitHeight = 22
      object lbCat: TLabel [1]
        Left = 352
        Top = 8
        Width = 70
        Height = 14
        Caption = 'Catalisador %:'
      end
      object edtCat: TEditFocus
        Left = 352
        Top = 24
        Width = 70
        Height = 22
        Alignment = taRightJustify
        TabOrder = 2
        Text = '0'
        OnExit = edtCatExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
  end
end
