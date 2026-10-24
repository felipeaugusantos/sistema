inherited frmFatManEquipDigDesconto: TfrmFatManEquipDigDesconto
  Width = 300
  Height = 388
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Desconto Especial'
  Position = poMainFormCenter
  ExplicitWidth = 300
  ExplicitHeight = 388
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 343
    Width = 294
    ExplicitTop = 315
    ExplicitWidth = 294
    inherited FlwBotoes: TFlowPanel
      Width = 290
    end
  end
  inherited pgcDados: TPageControl
    Left = 368
    Top = 304
    Width = 81
    Height = 73
    Align = alNone
    ExplicitLeft = 368
    ExplicitTop = 304
    ExplicitWidth = 81
    ExplicitHeight = 73
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 73
      ExplicitHeight = 41
    end
  end
  inherited pnlStatus: TPanel
    Top = 343
    Width = 294
    ExplicitTop = 315
    ExplicitWidth = 294
    inherited pnlNomeForm: TPanel
      Left = 144
      Width = 150
      Caption = 'frmFatManEquipDigDesconto'
      ExplicitLeft = 144
      ExplicitWidth = 150
    end
    inherited pnlInfo: TPanel
      Width = 144
      ExplicitWidth = 144
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 24
    Width = 294
    Height = 319
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 0
    ExplicitHeight = 315
    object pnlResumo: TPanel
      Left = 0
      Top = 237
      Width = 294
      Height = 54
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 233
      object lblTotal: TLabel
        Left = 38
        Top = 28
        Width = 129
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total L'#237'quido da O.S.:'
      end
      object pnlTopDesEsp: TPanel
        Left = 0
        Top = 0
        Width = 290
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblDesEsp: TLabel
          Left = 0
          Top = 1
          Width = 290
          Height = 20
          Align = alClient
          Alignment = taCenter
          Caption = 'Resumo'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          StyleElements = [seFont, seBorder]
          ExplicitWidth = 46
          ExplicitHeight = 14
        end
        object Shape1: TShape
          Left = 0
          Top = 0
          Width = 290
          Height = 1
          Align = alTop
          Pen.Color = clMedGray
          ExplicitWidth = 328
        end
      end
      object edtTotal: TEditFocus
        Left = 170
        Top = 25
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlDadosGerais: TPanel
      Left = 0
      Top = 0
      Width = 294
      Height = 105
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 0
      object lblTotPro: TLabel
        Left = 47
        Top = 28
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total dos Produtos:'
      end
      object lblTotSer: TLabel
        Left = 47
        Top = 51
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total dos Servi'#231'os:'
      end
      object lblTotCon: TLabel
        Left = 9
        Top = 75
        Width = 158
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total da Ordem de Servi'#231'o:'
      end
      object pnlTopDadosGerais: TPanel
        Left = 0
        Top = 0
        Width = 290
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblInfGerais: TLabel
          Left = 0
          Top = 1
          Width = 290
          Height = 20
          Align = alClient
          Alignment = taCenter
          Caption = 'Informa'#231#245'es Gerais da Ordem de Servi'#231'o'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          StyleElements = [seFont, seBorder]
          ExplicitWidth = 227
          ExplicitHeight = 14
        end
        object Shape2: TShape
          Left = 0
          Top = 0
          Width = 290
          Height = 1
          Align = alTop
          Pen.Color = clMedGray
          ExplicitWidth = 328
        end
      end
      object edtTotPro: TEditFocus
        Left = 170
        Top = 25
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotSer: TEditFocus
        Left = 170
        Top = 48
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotCon: TEditFocus
        Left = 170
        Top = 71
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlDesEsp: TPanel
      Left = 0
      Top = 105
      Width = 294
      Height = 132
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitHeight = 128
      object lblPerDes: TLabel
        Left = 90
        Top = 28
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = '% de Desconto:'
      end
      object lblTotDes: TLabel
        Left = 62
        Top = 51
        Width = 105
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor % do Desconto:'
      end
      object lblValDes: TLabel
        Left = 90
        Top = 75
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Desconto:'
      end
      object Label1: TLabel
        Left = 50
        Top = 99
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total do Desconto:'
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 290
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblTopDesEsp: TLabel
          Left = 0
          Top = 1
          Width = 290
          Height = 20
          Align = alClient
          Alignment = taCenter
          Caption = 'Desconto Especial'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          StyleElements = [seFont, seBorder]
          ExplicitWidth = 100
          ExplicitHeight = 14
        end
        object Shape3: TShape
          Left = 0
          Top = 0
          Width = 290
          Height = 1
          Align = alTop
          Pen.Color = clMedGray
          ExplicitWidth = 328
        end
      end
      object edtPerDes: TEditFocus
        Tag = 99
        Left = 170
        Top = 25
        Width = 110
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotPerDes: TEditFocus
        Left = 170
        Top = 48
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValDes: TEditFocus
        Tag = 99
        Left = 170
        Top = 72
        Width = 110
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotDes: TEditFocus
        Left = 170
        Top = 96
        Width = 110
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlConfirma: TPanel
      Left = 0
      Top = 291
      Width = 294
      Height = 28
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      ExplicitTop = 287
      object btnCancelaDados: TBitBtnLocked
        Left = 215
        Top = 2
        Width = 77
        Height = 24
        Align = alRight
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
        TabOrder = 1
        OnClick = btnCancelaDadosClick
      end
      object btnConfirmaDados: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 77
        Height = 24
        Align = alLeft
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
        OnClick = btnConfirmaDadosClick
      end
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 0
    Width = 294
    Height = 24
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 5
    StyleElements = [seBorder]
    object lblAplicarDesconto: TLabel
      Left = 0
      Top = 0
      Width = 290
      Height = 20
      Align = alClient
      Alignment = taCenter
      Caption = 'Aplicando desconto nos produtos e servi'#231'os'
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitWidth = 248
      ExplicitHeight = 14
    end
  end
end
