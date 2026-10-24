inherited frmFatReimpressaoManifestoEletronico: TfrmFatReimpressaoManifestoEletronico
  Width = 734
  Height = 458
  BorderStyle = bsDialog
  Caption = 'Reimpress'#227'o de manifesto eletr'#244'nico'
  Position = poOwnerFormCenter
  ExplicitWidth = 734
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 387
    Width = 728
    Height = 26
    ExplicitTop = 387
    ExplicitWidth = 728
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 634
      Height = 22
      ExplicitWidth = 634
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 120
        ExplicitWidth = 120
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 120
        Width = 120
        ExplicitLeft = 120
        ExplicitWidth = 120
      end
      object btnGravar: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Imprimir'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000C000000120000001400000014000000150000
          0015000000140000000D00000003000000000000000000000000000000000000
          00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
          78FFBE8978FF876356C30000000B000000000000000000000000000000030000
          000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
          E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
          42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
          72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
          6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
          76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
          71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
          35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
          78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
          DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
          7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
          32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
          86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
          42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
          8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
          DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
          84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
          E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
          2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
          E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
          0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
          E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
          00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
          EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
          00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
          FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
          000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
          91FFCDA391FF98786BC100000004000000000000000000000000}
        TabOrder = 2
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 636
      Top = 2
      Width = 90
      Align = alRight
      Caption = '&Cancela'
      ExplicitLeft = 636
      ExplicitTop = 2
      ExplicitWidth = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 413
    Width = 728
    ExplicitTop = 413
    ExplicitWidth = 728
    inherited pnlNomeForm: TPanel
      Left = 498
      Width = 230
      ExplicitLeft = 498
      ExplicitWidth = 230
    end
    inherited pnlInfo: TPanel
      Width = 498
      ExplicitWidth = 498
    end
  end
  inherited pnlHeader: TPanel
    Width = 728
    Height = 99
    ExplicitWidth = 728
    ExplicitHeight = 99
    object Label7: TLabel
      Left = 13
      Top = 9
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Manifesto:'
    end
    object Label1: TLabel
      Left = 25
      Top = 53
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o manifesto:'
    end
    object lblCodEmp: TLabel
      Left = 73
      Top = 75
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object lbl16: TLabel
      Left = 51
      Top = 32
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Placa Ve'#237'culo:'
    end
    object Label4: TLabel
      Left = 198
      Top = 56
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object rdgTipoDocumento: TcxRadioGroup
      Left = 547
      Top = 6
      Caption = 'Tipo de Documento'
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'NFe'
        end
        item
          Caption = 'Cte'
        end>
      ItemIndex = 0
      TabOrder = 1
      Height = 44
      Width = 108
    end
    object edtNumMan: TEditFocus
      Tag = 99
      Left = 121
      Top = 6
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object mskDtaIniMan: TMaskEditFocus
      Tag = 99
      Left = 121
      Top = 50
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFinMan: TMaskEditFocus
      Tag = 99
      Left = 210
      Top = 50
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 121
      Top = 72
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 196
      Top = 72
      Width = 343
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object btnAdicionar: TBitBtnLocked
      Left = 547
      Top = 72
      Width = 73
      Height = 22
      Caption = '&Filtrar'
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
      TabOrder = 7
      OnClick = btnAdicionarClick
    end
    object mskPlaVei: TMaskEditFocus
      Tag = 99
      Left = 121
      Top = 28
      Width = 72
      Height = 22
      Hint = 'Pressione INSERT para inserir um novo Ve'#237'culo'
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      EditMask = 'aaa-9a99;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = ''
      OnKeyPress = mskPlaVeiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtMarVei: TEditFocus
      Left = 196
      Top = 28
      Width = 148
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtModVei: TEditFocus
      Left = 347
      Top = 28
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 339
    Width = 728
    ExplicitTop = 339
    ExplicitWidth = 728
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 139
    Width = 728
    Height = 200
    TabStop = False
    ReadOnly = True
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMMAN'
        Title.Caption = 'Manifesto'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAMAN'
        Title.Caption = 'Dt. Manifesto'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMMOT'
        Title.Caption = 'Motorista'
        Width = 291
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLAMAN'
        Title.Caption = 'Placa'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLAMA2'
        Title.Caption = 'Placa Reboque'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTADO'
        Title.Caption = 'UF'
        Width = 30
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 99
    Width = 728
    ExplicitTop = 99
    ExplicitWidth = 728
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 28
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 0
  end
  inherited qryConsulta: TUniQuery
    Left = 496
  end
  inherited dtsConsulta: TDataSource
    Left = 592
  end
end
