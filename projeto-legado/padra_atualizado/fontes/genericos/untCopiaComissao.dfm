inherited frmCopiaComissao: TfrmCopiaComissao
  Width = 525
  Height = 162
  Caption = 'Copiar Comiss'#227'o Para Outos Produtos'
  Position = poMainFormCenter
  ExplicitWidth = 525
  ExplicitHeight = 162
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 89
    Width = 519
    ExplicitTop = 89
    ExplicitWidth = 519
    inherited FlwBotoes: TFlowPanel
      Width = 515
      ExplicitWidth = 515
      object btnAdicionar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 104
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnAdicionarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 436
      ExplicitLeft = 436
    end
  end
  inherited pnlStatus: TPanel
    Top = 117
    Width = 519
    ExplicitTop = 117
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 348
      ExplicitLeft = 348
    end
    inherited pnlInfo: TPanel
      Width = 348
      ExplicitWidth = 348
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 89
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object FlowPanel1: TFlowPanel
      Left = 1
      Top = 1
      Width = 517
      Height = 87
      Align = alClient
      FlowStyle = fsTopBottomLeftRight
      TabOrder = 0
      object chkComVar: TCheckBox
        Left = 1
        Top = 1
        Width = 176
        Height = 17
        Caption = 'Vendedor Interno'
        TabOrder = 0
      end
      object chkComAta: TCheckBox
        Left = 1
        Top = 19
        Width = 176
        Height = 17
        Caption = 'Representante Externo Loja'
        TabOrder = 1
      end
      object chkComDis: TCheckBox
        Left = 1
        Top = 37
        Width = 216
        Height = 17
        Caption = 'Representante Externo Distribuidora'
        TabOrder = 2
      end
      object pnlTabela: TPanel
        Left = 1
        Top = 55
        Width = 546
        Height = 26
        BevelOuter = bvNone
        TabOrder = 3
        object flwpnlTabelas: TFlowPanel
          Left = 0
          Top = 0
          Width = 546
          Height = 26
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object chkTabela1: TCheckBox
            Left = 0
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 1'
            TabOrder = 0
            Visible = False
          end
          object chkTabela2: TCheckBox
            Left = 70
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 2'
            TabOrder = 1
            Visible = False
          end
          object chkTabela3: TCheckBox
            Left = 140
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 3'
            TabOrder = 2
            Visible = False
          end
          object chkTabela4: TCheckBox
            Left = 210
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 4'
            TabOrder = 3
            Visible = False
          end
          object chkTabela5: TCheckBox
            Left = 280
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 5'
            TabOrder = 4
            Visible = False
          end
          object chkTabela6: TCheckBox
            Left = 350
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 6'
            TabOrder = 5
            Visible = False
          end
          object chkTabela7: TCheckBox
            Left = 420
            Top = 0
            Width = 70
            Height = 17
            Caption = 'Tab 7'
            TabOrder = 6
            Visible = False
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 8
  end
end
