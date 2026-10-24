inherited frmMensagemNegociacaoOS: TfrmMensagemNegociacaoOS
  Width = 720
  Height = 393
  Caption = 'Ordens de Servi'#231'o com Negocia'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 720
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 324
    Width = 714
    Height = 24
    ExplicitTop = 324
    ExplicitWidth = 714
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Width = 710
      Height = 20
      ExplicitWidth = 710
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 631
      Top = 1
      Caption = '&OK'
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
      ExplicitLeft = 631
      ExplicitTop = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 348
    Width = 714
    ExplicitTop = 348
    ExplicitWidth = 714
    inherited pnlNomeForm: TPanel
      Left = 543
      ExplicitLeft = 543
    end
    inherited pnlInfo: TPanel
      Width = 543
      ExplicitWidth = 543
    end
  end
  object pnlMsg: TPanel [3]
    Left = 0
    Top = 0
    Width = 714
    Height = 65
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object memMsg: TMemo
      Left = 1
      Top = 1
      Width = 712
      Height = 63
      Align = alClient
      Alignment = taCenter
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Lines.Strings = (
        ''
        
          'Aten'#231#227'o! As ordens relacionadas abaixo j'#225' possuem negocia'#231#245'es vi' +
          'nculadas. Se a negocia'#231#227'o estiver finalizada, ela ser'#225' carregada' +
          ' no grid '
        
          'para uma nova negocia'#231#227'o. Contudo, Se a negocia'#231#227'o estiver em ab' +
          'erto, carregue a mesma para alter'#225'-la.')
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      StyleElements = []
    end
  end
  object dbgGridDfe: TDBGridCitel [4]
    Left = 0
    Top = 65
    Width = 714
    Height = 259
    Align = alClient
    DataSource = dtsNegociacoes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = cl3DLight
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMOSE'
        Title.Caption = 'O.S.'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'C'#243'd. Empresa'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCLI'
        Title.Caption = 'C'#243'd. Cliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCLI'
        Title.Caption = 'Nome Cliente'
        Width = 249
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NRONEG'
        Title.Caption = 'Nro. Negocia'#231#227'o'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = 'Status Negocia'#231#227'o'
        Width = 96
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VLRCON'
        Title.Caption = 'Valor O.S.'
        Width = 68
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 144
  end
  object dtsNegociacoes: TDataSource
    Left = 424
    Top = 144
  end
end
