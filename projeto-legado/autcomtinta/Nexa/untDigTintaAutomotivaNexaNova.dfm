inherited frmDigTintaAutomotivaNexaNova: TfrmDigTintaAutomotivaNexaNova
  Left = 383
  Top = 224
  Width = 439
  Height = 550
  ExplicitWidth = 439
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 478
    Width = 433
    ExplicitTop = 478
    ExplicitWidth = 433
    inherited btnSair: TBitBtnLocked
      Left = 350
      ExplicitLeft = 350
    end
  end
  inherited pnlGeral: TPanel
    Width = 433
    Height = 478
    ExplicitWidth = 433
    ExplicitHeight = 478
    inherited pnlCabecalho: TPanel
      Width = 431
      Height = 198
      ExplicitWidth = 431
      ExplicitHeight = 198
      inherited gpbEmbalagem: TGroupBox
        Height = 186
        ExplicitHeight = 186
        inherited lblTipo: TLabel
          Top = 119
          ExplicitTop = 119
        end
        inherited rdbLitro: TRadioButton
          OnExit = rdbLitroExit
        end
        inherited rdbGalao: TRadioButton
          OnClick = rdbGalaoClick
          OnExit = rdbLitroExit
        end
        inherited rdbCopo: TRadioButton
          Caption = '&Balde'
          OnClick = rdbCopoClick
          OnExit = rdbLitroExit
        end
        inherited rdbSpray: TRadioButton
          Caption = '&Tambor'
          TabOrder = 5
          OnClick = rdbSprayClick
          OnExit = rdbLitroExit
        end
        inherited rdgAcerto: TRadioGroup
          Top = 141
          TabOrder = 10
          ExplicitTop = 141
        end
        inherited rdbTambor: TRadioButton
          TabOrder = 6
          OnClick = rdbSprayClick
          OnExit = rdbLitroExit
        end
        inherited rdbLata: TRadioButton
          TabOrder = 7
          OnClick = rdbLataClick
          OnExit = rdbLitroExit
        end
        inherited cmbTipoEmbalagem: TComboBoxFocus
          Top = 111
          Enabled = False
          TabOrder = 9
          ExplicitTop = 111
        end
        inherited rdbBalde: TRadioButton
          TabOrder = 8
          OnClick = rdbBaldeClick
          OnExit = rdbLitroExit
        end
        object rdbCopoNexa: TRadioButton
          Left = 8
          Top = 93
          Width = 57
          Height = 17
          Caption = '&Copo'
          TabOrder = 4
          OnClick = rdbCopoNexaClick
          OnExit = rdbLitroExit
        end
      end
      inherited pnlPreco: TPanel
        Left = 223
        Top = 13
        Height = 175
        ExplicitLeft = 223
        ExplicitTop = 13
        ExplicitHeight = 175
        inherited Label4: TLabel
          Top = 107
          ExplicitTop = 107
        end
        inherited Label5: TLabel
          Top = 59
          ExplicitTop = 59
        end
        inherited Label2: TLabel
          Top = 11
          ExplicitTop = 11
        end
        inherited edtPreco: TEditFocus
          Top = 123
          ExplicitTop = 123
        end
        inherited edtPreEmb: TEditFocus
          Top = 75
          ExplicitTop = 75
        end
        inherited edtPrecoSemEmb: TEditFocus
          Top = 27
          ExplicitTop = 27
        end
      end
    end
    inherited pnlAdicional: TPanel
      Top = 353
      Width = 431
      Height = 57
      ExplicitTop = 353
      ExplicitWidth = 431
      ExplicitHeight = 57
      object lblPorcentagemDiluente: TLabel [1]
        Left = 352
        Top = 8
        Width = 54
        Height = 14
        Caption = 'Diluente %:'
      end
      inherited cmbListaAdicional: TComboBoxFocus
        Width = 169
        ExplicitWidth = 169
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
      Top = 410
      Width = 431
      Height = 67
      ExplicitTop = 410
      ExplicitWidth = 431
      ExplicitHeight = 67
      inherited chkComCat: TCheckBox
        Visible = False
      end
    end
    inherited pnlTrocaEmb: TPanel
      Top = 57
      Width = 431
      TabOrder = 1
      ExplicitTop = 57
      ExplicitWidth = 431
    end
    inherited pnlConsEmb: TPanel
      Top = 114
      Width = 431
      TabOrder = 2
      ExplicitTop = 114
      ExplicitWidth = 431
    end
    inherited pnlModoVenda: TPanel
      Width = 431
      ExplicitWidth = 431
      inherited rdgModoVenda: TRadioGroup
        Width = 429
        ExplicitWidth = 429
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 506
    Width = 433
    ExplicitTop = 506
    ExplicitWidth = 433
    inherited pnlNomeForm: TPanel
      Left = 262
      ExplicitLeft = 262
    end
    inherited pnlInfo: TPanel
      Width = 262
      ExplicitWidth = 262
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 80
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 16
    Top = 16
  end
  inherited PopupMenu1: TPopupMenu
    Left = 48
    Top = 16
  end
end
