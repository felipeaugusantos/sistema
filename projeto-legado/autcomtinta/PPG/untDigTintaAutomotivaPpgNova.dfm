inherited frmDigTintaAutomotivaPpgNova: TfrmDigTintaAutomotivaPpgNova
  Left = 383
  Top = 224
  Width = 439
  Height = 618
  ExplicitWidth = 439
  ExplicitHeight = 618
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 546
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
    Height = 546
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
        inherited rdbGalao: TRadioButton
          OnClick = rdbGalaoClick
        end
        inherited rdbCopo: TRadioButton
          Caption = '&Balde'
          OnClick = rdbBaldeClick
        end
        inherited rdbSpray: TRadioButton
          Caption = '&Tambor'
          TabOrder = 5
          OnClick = rdbSprayClick
        end
        inherited rdgAcerto: TRadioGroup
          Top = 141
          TabOrder = 10
          ExplicitTop = 141
        end
        inherited rdbTambor: TRadioButton
          TabOrder = 6
          OnClick = rdbSprayClick
        end
        inherited rdbLata: TRadioButton
          TabOrder = 7
          OnClick = rdbLataClick
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
        end
        object rdbCopoPpg: TRadioButton
          Left = 8
          Top = 93
          Width = 57
          Height = 17
          Caption = '&Copo'
          TabOrder = 4
          OnClick = rdbCopoPpgClick
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
          Top = 124
          ExplicitTop = 124
        end
        inherited Label5: TLabel
          Top = 76
          ExplicitTop = 76
        end
        inherited Label2: TLabel
          Top = 28
          ExplicitTop = 28
        end
        inherited edtPreco: TEditFocus
          Top = 140
          ExplicitTop = 140
        end
        inherited edtPreEmb: TEditFocus
          Top = 92
          ExplicitTop = 92
        end
        inherited edtPrecoSemEmb: TEditFocus
          Top = 44
          ExplicitTop = 44
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
      Height = 52
      ExplicitTop = 410
      ExplicitWidth = 431
      ExplicitHeight = 67
      inherited chkComCat: TCheckBox
        Visible = False
      end
    end
    inherited pnlTrocaEmb: TPanel
      Width = 431
      ExplicitWidth = 431
    end
    inherited pnlConsEmb: TPanel
      Width = 431
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
    inherited pnlObservacao: TPanel
      Top = 462
      Width = 431
      ExplicitLeft = 24
      ExplicitTop = 155
      ExplicitWidth = 431
    end
  end
  inherited pnlStatus: TPanel
    Top = 574
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
