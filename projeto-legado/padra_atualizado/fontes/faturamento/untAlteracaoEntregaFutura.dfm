inherited frmAlteracaoEntregaFutura: TfrmAlteracaoEntregaFutura
  Left = 156
  Top = 100
  Width = 764
  Height = 447
  Caption = 'Altera'#231#227'o de Entrega Futura'
  ExplicitWidth = 764
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 364
    Width = 748
    TabOrder = 5
    ExplicitTop = 364
    ExplicitWidth = 748
    inherited FlwBotoes: TFlowPanel
      Width = 744
      ExplicitWidth = 744
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 160
        ExplicitWidth = 160
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 160
        Width = 160
        ExplicitLeft = 160
        ExplicitWidth = 160
      end
      object btnConfirma: TBitBtnLocked
        Left = 320
        Top = 0
        Width = 160
        Height = 22
        Caption = 'Confirmar [F10]'
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
        OnClick = btnConfirmaClick
      end
      object btnAlteracaoLote: TBitBtnLocked
        Left = 480
        Top = 0
        Width = 160
        Height = 22
        Caption = '[F9] Altera'#231#227'o de Armaz'#233'm'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnAlteracaoLoteClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 641
      Top = 2
      Width = 103
      ExplicitLeft = 641
      ExplicitTop = 2
      ExplicitWidth = 103
    end
  end
  inherited pnlStatus: TPanel
    Top = 392
    Width = 748
    TabOrder = 6
    ExplicitTop = 392
    ExplicitWidth = 748
    inherited pnlNomeForm: TPanel
      Left = 577
      ExplicitLeft = 577
    end
    inherited pnlInfo: TPanel
      Width = 577
      ExplicitWidth = 577
    end
  end
  inherited pnlHeader: TPanel
    Width = 748
    Height = 99
    TabOrder = 0
    ExplicitWidth = 748
    ExplicitHeight = 99
    object Label27: TLabel
      Left = 9
      Top = 28
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label1: TLabel
      Left = 23
      Top = 51
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 33
      Top = 73
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lblTipoDocumento: TLabel
      Left = 440
      Top = 51
      Width = 281
      Height = 46
      AutoSize = False
      Caption = 'lblTipoDocumento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 748
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Informa'#231#245'es para Sele'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      StyleElements = [seBorder]
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 72
      Top = 24
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 153
      Top = 24
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 72
      Top = 47
      Width = 41
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
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
      Left = 113
      Top = 47
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 72
      Top = 69
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 145
      Top = 69
      Width = 285
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
  end
  inherited pnlTail: TPanel
    Top = 288
    Width = 748
    Height = 34
    ExplicitTop = 288
    ExplicitWidth = 748
    ExplicitHeight = 34
    object lblMotFut: TLabel
      Left = 9
      Top = 13
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object lblDtaFut: TLabel
      Left = 346
      Top = 13
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Entrega:'
    end
    object lblCliBus: TLabel
      Left = 183
      Top = 13
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente vai retirar?'
    end
    object mskDtaFut: TMaskEditFocus
      Tag = 99
      Left = 387
      Top = 9
      Width = 73
      Height = 22
      Enabled = False
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnKeyPress = mskDtaFutKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 586
      Top = 9
      Width = 111
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 4
      OnClick = btnCancelaItemClick
    end
    object btnAdicionar: TBitBtnLocked
      Left = 474
      Top = 9
      Width = 111
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
      TabOrder = 3
      OnClick = btnAdicionarClick
    end
    object cmbMotEntFut: TComboBoxFocus
      Tag = 99
      Left = 45
      Top = 9
      Width = 132
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnChange = cmbMotEntFutChange
      Items.Strings = (
        'Falta Produto'
        'Aguardando Cliente'
        'Previs'#227'o de Entrega')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbCliBus: TComboBoxFocus
      Tag = 99
      Left = 272
      Top = 9
      Width = 65
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Items.Strings = (
        'N'#195'O'
        'SIM')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 139
    Width = 748
    Height = 134
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnDrawDataCell = nil
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_CODITE'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 217
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 76
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unit'#225'rio'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DET_MOTFUT'
        Title.Alignment = taCenter
        Title.Caption = 'Mot.'
        Width = 24
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DET_CLIBUS'
        Title.Alignment = taCenter
        Title.Caption = 'C.Ret.'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DTAFUT'
        Title.Caption = 'Previs'#227'o'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDIS'
        Title.Caption = 'Saldo Disp.'
        Width = 58
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 99
    Width = 748
    TabOrder = 7
    ExplicitTop = 99
    ExplicitWidth = 748
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  object pnlAviso: TPanel [6]
    Left = 0
    Top = 322
    Width = 748
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Color = clInfoBk
    Enabled = False
    ParentBackground = False
    TabOrder = 4
    Visible = False
    object mmoAviso: TMemo
      Left = 0
      Top = 0
      Width = 748
      Height = 42
      Align = alClient
      Color = clInfoBk
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Lines.Strings = (
        
          'Todos os itens com entrega futura pendentes, deste documento, cu' +
          'jo motivo seja "Previs'#227'o" '
        'ser'#227'o atualizados com a data abaixo.')
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      StyleElements = [seFont, seBorder]
    end
  end
  object pnlLegenda: TPanel [7]
    Left = 0
    Top = 273
    Width = 748
    Height = 15
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    object lblLegenda: TLabel
      Left = 0
      Top = 0
      Width = 387
      Height = 14
      Align = alClient
      Alignment = taCenter
      Caption = 
        '[P] Previs'#227'o de Entrega       [A] Aguardando Cliente       [F] F' +
        'alta Produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 584
    Top = 40
  end
  inherited qryConsulta: TUniQuery
    Left = 520
    Top = 8
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 552
    Top = 8
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterScroll = cdsConsultaAfterScroll
    Left = 584
    Top = 8
  end
  inherited dtsConsulta: TDataSource
    Left = 616
    Top = 8
  end
end
