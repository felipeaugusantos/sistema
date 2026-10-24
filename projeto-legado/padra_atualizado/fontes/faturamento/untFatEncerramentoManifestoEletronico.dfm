inherited frmFatEncerramentoManifestoEletronico: TfrmFatEncerramentoManifestoEletronico
  Height = 458
  Caption = 'Encerramento de manifesto eletr'#244'nico'
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Height = 26
    ExplicitTop = 377
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 636
      Height = 22
      ExplicitWidth = 636
      ExplicitHeight = 22
      inherited btnPesquisar: TBitBtnLocked
        Width = 105
        ExplicitWidth = 105
      end
      object btnGravar: TBitBtnLocked
        Left = 223
        Top = 0
        Width = 104
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 638
      Top = 2
      Align = alRight
      ExplicitLeft = 638
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 403
    ExplicitTop = 403
  end
  inherited pnlHeader: TPanel
    Height = 99
    ExplicitHeight = 99
    object Label7: TLabel
      Left = 13
      Top = 11
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Manifesto:'
    end
    object Label1: TLabel
      Left = 25
      Top = 54
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o manifesto:'
    end
    object lblCodEmp: TLabel
      Left = 73
      Top = 80
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
      Left = 188
      Top = 56
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object rdgTipoDocumento: TcxRadioGroup
      Left = 559
      Top = 4
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
      Height = 35
      Width = 129
    end
    object edtNumMan: TEditFocus
      Tag = 99
      Left = 121
      Top = 6
      Width = 61
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
      Width = 62
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
      Left = 200
      Top = 50
      Width = 66
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
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 6
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 194
      Top = 72
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 516
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
      TabOrder = 8
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
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtModVei: TEditFocus
      Left = 344
      Top = 28
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkCarPos: TcxCheckBox
      Left = 271
      Top = 50
      Caption = 'Documentos n'#227'o Carregados - Apenas Retirada de Produtos.'
      TabOrder = 5
      OnClick = chkCarPosClick
    end
  end
  inherited pnlTail: TPanel
    Top = 329
    ExplicitTop = 329
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 139
    Height = 190
    TabStop = False
    ReadOnly = True
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMMAN'
        Title.Caption = 'Manifesto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAMAN'
        Title.Caption = 'Dt. Manif.'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMMOT'
        Title.Caption = 'Motorista'
        Width = 281
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
        Width = 25
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 99
    ExplicitTop = 99
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
