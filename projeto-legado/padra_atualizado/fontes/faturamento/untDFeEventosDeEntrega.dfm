inherited frmDFeEventosDeEntrega: TfrmDFeEventosDeEntrega
  Width = 806
  Height = 217
  BorderStyle = bsDialog
  Caption = 'Eventos de Entrega'
  Position = poDesktopCenter
  ExplicitWidth = 806
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 144
    Width = 800
    TabOrder = 3
    ExplicitTop = 144
    ExplicitWidth = 800
    inherited FlwBotoes: TFlowPanel
      Width = 796
      ExplicitWidth = 796
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 20
        Caption = '&Confirma'
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
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 720
      ExplicitLeft = 720
    end
  end
  inherited pnlStatus: TPanel
    Top = 172
    Width = 800
    TabOrder = 4
    ExplicitTop = 172
    ExplicitWidth = 800
    inherited pnlNomeForm: TPanel
      Left = 629
      ExplicitLeft = 629
    end
    inherited pnlInfo: TPanel
      Width = 629
      ExplicitWidth = 629
    end
  end
  object pnlConfirmacao: TPanel [2]
    Left = 0
    Top = 0
    Width = 800
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblDocRecebedor: TLabel
      Left = 6
      Top = 13
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc.Recebedor:'
    end
    object lblNomRecebedor: TLabel
      Left = 230
      Top = 13
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome do Recebedor:'
    end
    object edtDocRecebedor: TEditFocus
      Tag = 99
      Left = 88
      Top = 9
      Width = 120
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
    object edtNomRecebedor: TEditFocus
      Tag = 99
      Left = 335
      Top = 9
      Width = 455
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 60
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlInsucesso: TPanel [3]
    Left = 0
    Top = 36
    Width = 800
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      Left = 50
      Top = 11
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object Label1: TLabel
      Left = 266
      Top = 12
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nr.Tentativas:'
    end
    object Label4: TLabel
      Left = 400
      Top = 11
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Justificativa:'
    end
    object cboMotivo: TComboBoxFocus
      Left = 88
      Top = 8
      Width = 168
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Recebedor n'#227'o encontrado'
      Items.Strings = (
        'Recebedor n'#227'o encontrado'
        'Recusa do recebedor'
        'Endere'#231'o inexistente'
        'Outros')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtNroTentativas: TEditFocus
      Tag = 99
      Left = 335
      Top = 8
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttInteiro
    end
    object edtJustificativa: TEditFocus
      Tag = 99
      Left = 464
      Top = 8
      Width = 326
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 250
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 250
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCanhoto: TPanel [4]
    Left = 0
    Top = 72
    Width = 800
    Height = 68
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblLatitude: TLabel
      Left = 41
      Top = 10
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Latitude:'
    end
    object lblLongitude: TLabel
      Left = 279
      Top = 10
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Longitude:'
    end
    object lblDtaCanhoto: TLabel
      Left = 14
      Top = 41
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Canhoto:'
    end
    object lblHashCanhoto: TLabel
      Left = 249
      Top = 45
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Foto do Canhoto:'
    end
    object edtLatitude: TEditFocus
      Tag = 99
      Left = 88
      Top = 6
      Width = 116
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtLongitude: TEditFocus
      Tag = 99
      Left = 335
      Top = 6
      Width = 123
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object mskDtaCanhoto: TMaskEditFocus
      Left = 88
      Top = 38
      Width = 63
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnExit = mskDtaCanhotoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskHraCanhoto: TMaskEditFocus
      Left = 159
      Top = 38
      Width = 43
      Height = 22
      EditMask = '!99:99;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      Text = '  :  '
      OnExit = mskHraCanhotoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtHashCanhoto: TEditFocus
      Tag = 99
      Left = 335
      Top = 41
      Width = 309
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16770261
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16770261
      FocusColor = 16770261
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionarCanhoto: TBitBtnLocked
      Left = 650
      Top = 40
      Width = 140
      Height = 25
      Caption = 'Adicionar Canhoto'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000051543
        30BC1D5D42FF1D5D42FF15422FBD000000050000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000061E65
        48FF63DBB3FF2FCB95FF1B5F43FF0000000700000000000000000000000A0000
        000F0000001100000011000000110000001200000016000000180000001C216E
        4FFF6EDEBAFF36D09CFF1E6649FF0000001000000007000000057F5648C1B076
        63FFAF7562FFAF7562FFAF7561FFD0B0A5FF54886EFF237556FF237152FF2475
        56FF41D5A4FF40D2A4FF216E50FF1F6448FF1E6246FF154531BCB27B68FFF8F2
        EDFFF8F2EDFFF8F1EEFFF9F2EDFFF8F4F2FF298663FF88E8CBFF4EDAADFF4CDA
        ACFF4BD9ACFF48D9AAFF47D7ABFF46D6AAFF45D6A6FF216F50FFB57E6BFFF9F3
        EFFFF7EFEAFF8C6F63FFF7EFE9FFF7F3F0FF2C8E6BFF90EBD0FF8EEACFFF8DEA
        CFFF8BE9CDFF52DEB3FF51DCB2FF86E7C9FF83E7C9FF247757FFB7826FFFF9F4
        F1FF8F7266FF8E7164FF8D7064FFBEB0A9FF549C7FFF2E926EFF2E906DFF2D8E
        6BFF92EBD3FF59E0B8FF2A8764FF298362FF288260FF1D5E46C0BA8573FFFAF5
        F3FFF8F1EBFF907367FFF7F0EBFFF9F3EEFFE8DCD8FFF9F5F2FFF5F2EFFF2F95
        71FF9BEED7FF5FE4BEFF2D8F6CFF000000170000000400000003BD8977FFFAF6
        F4FF93766BFF92756AFFDFCDC6FFDECCC5FFDECAC4FFDDCAC3FFEBE1DEFF329B
        77FF9EF0DAFF9DEFDAFF2F9572FF000000120000000000000000C08C7BFFFAF8
        F5FFF8F3EFFF94796DFFF8F2EEFFF8F3EFFFDFCDC7FFF8F2EEFFFAF7F5FF60AB
        8DFF34A07BFF339E78FF5DA486FF0000000F0000000000000000C3917FFFFBF9
        F6FF977B70FF967B6FFFE2D2CCFFE2D1CBFFE1CFC9FFE0CFC8FFE4D4CFFFDDC0
        B4FFFAF7F6FFFBF9F8FFD3B4A9FF0000000C0000000000000000C59483FFFCF9
        F7FFFAF5F2FF997E71FFFAF5F1FFFAF5F1FFE4D2CCFFFAF5F1FFF9F4F1FFCA9B
        87FFFAF5F0FFFBF8F6FFBD8977FF0000000C0000000000000000C79787FFFDFA
        F8FF9B8175FF9B7F73FFCFA692FFCFA490FFCEA38FFFCDA08CFFCC9F8AFFCC9D
        89FFFAF6F1FFFCF9F7FFBF8D7CFF0000000B0000000000000000C99A8AFFFCFB
        F9FFFDFBF9FFFDFBF9FFFDFBF9FFFDFBF9FFFCFBF9FFFCFBF8FFFCFBF8FFFDFA
        F8FFFDFBF8FFFCFAF8FFC2917FFF0000000A0000000000000000CC9E8EFFFDFB
        F9FFFDFBFAFFFCFBF9FFFDFBFAFFFDFBF9FFFDFBF9FFFDFBF9FFFDFBFAFFFDFB
        F9FFFCFBF9FFFCFBF9FFC59583FF00000008000000000000000098776AC1CDA0
        8FFFCC9F8EFFCC9E8EFFCB9E8DFFCA9D8CFFCA9D8CFFCA9B8BFFC99A8AFFC99A
        89FFC89989FFC79988FF947164C2000000050000000000000000}
      TabOrder = 5
      OnClick = btnAdicionarCanhotoClick
    end
  end
  object FileOpenImagem: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Imagens'
        FileMask = '*.jpg'
      end>
    Options = []
    Left = 116
    Top = 132
  end
end
