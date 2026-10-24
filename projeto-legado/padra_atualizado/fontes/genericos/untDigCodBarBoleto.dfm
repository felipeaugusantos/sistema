inherited frmDigCodBarBoleto: TfrmDigCodBarBoleto
  Left = 282
  Top = 92
  Width = 844
  Height = 734
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de C'#243'digo de barras/Linha digit'#225'vel da duplicata'
  Position = poMainFormCenter
  ExplicitWidth = 844
  ExplicitHeight = 734
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 689
    Width = 838
    ExplicitTop = 689
    ExplicitWidth = 838
    DesignSize = (
      838
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 834
      ExplicitTop = 2
      ExplicitWidth = 834
    end
    inherited btnSair: TBitBtnLocked
      Left = 319
      ExplicitLeft = 319
    end
  end
  inherited pgcDados: TPageControl
    Top = 396
    Width = 849
    Height = 0
    Align = alNone
    TabOrder = 1
    Visible = False
    ExplicitTop = 396
    ExplicitWidth = 849
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 841
      ExplicitHeight = 428
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 838
    Height = 689
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object pnlBotoesBaixa: TPanel
      Left = 2
      Top = 660
      Width = 834
      Height = 27
      Align = alBottom
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 2
      object btnSairDig: TBitBtnLocked
        Left = 734
        Top = 2
        Width = 98
        Height = 23
        Align = alRight
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        TabOrder = 1
        OnClick = btnSairClick
      end
      object btnSalvar: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 98
        Height = 23
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
        OnClick = btnSalvarClick
      end
    end
    object pnlDuplics: TPanel
      Left = 2
      Top = 30
      Width = 834
      Height = 630
      Align = alClient
      ParentColor = True
      TabOrder = 1
      object pnl13: TPanel
        Left = 1
        Top = 322
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 13
        object Label3: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '13'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq13: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen13: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal13: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar13: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig13: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl14: TPanel
        Left = 1
        Top = 347
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 14
        object Label16: TLabel
          Left = 9
          Top = 11
          Width = 12
          Height = 14
          Caption = '14'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtDtaVen14: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtSeq14: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVal14: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar14: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig14: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl15: TPanel
        Left = 1
        Top = 372
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 15
        object Label17: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '15'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq15: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen15: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal15: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar15: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig15: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl17: TPanel
        Left = 1
        Top = 422
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 17
        object Label19: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '17'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq17: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen17: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal17: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar17: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig17: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl16: TPanel
        Left = 1
        Top = 397
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 16
        object Label18: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '16'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq16: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen16: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal16: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar16: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig16: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl18: TPanel
        Left = 1
        Top = 447
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 18
        object Label20: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '18'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq18: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen18: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal18: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar18: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig18: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl20: TPanel
        Left = 1
        Top = 497
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 20
        object Label22: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '20'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq20: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen20: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal20: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar20: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig20: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl19: TPanel
        Left = 1
        Top = 472
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 19
        object Label21: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '19'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq19: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen19: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal19: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar19: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig19: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl22: TPanel
        Left = 1
        Top = 547
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 22
        object Label24: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '22'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq22: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen22: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal22: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar22: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig22: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl21: TPanel
        Left = 1
        Top = 522
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 21
        object Label23: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '21'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq21: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen21: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal21: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar21: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig21: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl24: TPanel
        Left = 1
        Top = 597
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 24
        object Label27: TLabel
          Left = 9
          Top = 5
          Width = 12
          Height = 14
          Caption = '24'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq24: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen24: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal24: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar24: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig24: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl23: TPanel
        Left = 1
        Top = 572
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 23
        object Label25: TLabel
          Left = 9
          Top = 9
          Width = 12
          Height = 14
          Caption = '23'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq23: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen23: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal23: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar23: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig23: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl1: TPanel
        Left = 1
        Top = 22
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label4: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq1: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen1: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal1: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar1: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig1: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl2: TPanel
        Left = 1
        Top = 47
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object Label5: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtDtaVen2: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtSeq2: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVal2: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar2: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig2: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl3: TPanel
        Left = 1
        Top = 72
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object Label6: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq3: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen3: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal3: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar3: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig3: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl5: TPanel
        Left = 1
        Top = 122
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 5
        object Label8: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq5: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen5: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal5: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar5: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig5: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl4: TPanel
        Left = 1
        Top = 97
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 4
        object Label7: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq4: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen4: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal4: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar4: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig4: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl6: TPanel
        Left = 1
        Top = 147
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 6
        object Label9: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '6'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq6: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen6: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal6: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar6: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig6: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl8: TPanel
        Left = 1
        Top = 197
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 8
        object Label11: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '8'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq8: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen8: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal8: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar8: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig8: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl7: TPanel
        Left = 1
        Top = 172
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 7
        object Label10: TLabel
          Left = 15
          Top = 6
          Width = 6
          Height = 14
          Caption = '7'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq7: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen7: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal7: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar7: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig7: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl10: TPanel
        Left = 1
        Top = 247
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 10
        object Label13: TLabel
          Left = 9
          Top = 5
          Width = 12
          Height = 14
          Caption = '10'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq10: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen10: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal10: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar10: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig10: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl9: TPanel
        Left = 1
        Top = 222
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 9
        object Label12: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq9: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen9: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal9: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar9: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig9: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl12: TPanel
        Left = 1
        Top = 297
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 12
        object Label15: TLabel
          Left = 9
          Top = 5
          Width = 12
          Height = 14
          Caption = '12'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq12: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen12: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal12: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar12: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig12: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnl11: TPanel
        Left = 1
        Top = 272
        Width = 832
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 11
        object Label14: TLabel
          Left = 9
          Top = 5
          Width = 11
          Height = 14
          Caption = '11'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSeq11: TEditFocus
          Left = 24
          Top = 2
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDtaVen11: TMaskEditFocus
          Left = 48
          Top = 2
          Width = 60
          Height = 22
          AutoSize = False
          Enabled = False
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtVal11: TEditFocus
          Tag = 99
          Left = 112
          Top = 2
          Width = 66
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodBar11: TEditFocus
          Tag = 99
          Left = 185
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLinDig11: TEditFocus
          Tag = 99
          Left = 507
          Top = 2
          Width = 315
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlHeader: TPanel
        Left = 1
        Top = 1
        Width = 832
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 7
          Width = 97
          Height = 14
          Caption = 'N'#250'mero de Parcelas'
        end
        object Label1: TLabel
          Left = 113
          Top = 7
          Width = 25
          Height = 14
          Caption = 'Valor'
        end
        object chkCodBar: TCheckBox
          Tag = 99
          Left = 186
          Top = 2
          Width = 232
          Height = 17
          Caption = 'Leitor de C'#243'digo de Barras'
          TabOrder = 0
          OnClick = chkCodBarClick
        end
        object chkLinDig: TCheckBox
          Tag = 99
          Left = 510
          Top = 2
          Width = 232
          Height = 17
          Caption = 'Informar Linha Digit'#225'vel manualmente'
          TabOrder = 1
          OnClick = chkLinDigClick
        end
      end
    end
    object pnlValPad: TPanel
      Left = 2
      Top = 2
      Width = 834
      Height = 28
      Align = alTop
      ParentColor = True
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 689
    Width = 838
    TabOrder = 3
    ExplicitTop = 689
    ExplicitWidth = 838
    inherited pnlNomeForm: TPanel
      Left = 696
      Top = 16
      Width = 142
      Height = 0
      ExplicitLeft = 696
      ExplicitTop = 16
      ExplicitWidth = 142
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 838
      Align = alTop
      ExplicitWidth = 838
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 352
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 352
  end
end
