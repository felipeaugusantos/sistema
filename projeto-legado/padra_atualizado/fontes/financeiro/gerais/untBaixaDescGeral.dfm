inherited frmBaixaDescGeral: TfrmBaixaDescGeral
  Width = 368
  Height = 401
  BorderIcons = [biSystemMenu]
  Caption = 'Aplicar Desconto Geral'
  Position = poMainFormCenter
  ExplicitWidth = 368
  ExplicitHeight = 401
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 328
    Width = 362
    TabOrder = 3
    ExplicitTop = 328
    ExplicitWidth = 362
    inherited FlwBotoes: TFlowPanel
      Width = 358
      TabOrder = 1
      ExplicitWidth = 358
    end
    inherited btnSair: TBitBtnLocked
      Left = 279
      TabOrder = 2
      ExplicitLeft = 279
    end
    object btnConfirma: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 72
      Height = 22
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
  inherited pnlStatus: TPanel
    Top = 356
    Width = 362
    TabOrder = 4
    ExplicitTop = 356
    ExplicitWidth = 362
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
  object pnlValores: TPanel [2]
    Left = 0
    Top = 0
    Width = 362
    Height = 100
    Align = alTop
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      362
      100)
    object Label6: TLabel
      Left = 12
      Top = 9
      Width = 80
      Height = 14
      Caption = 'Valor Baixa Total'
    end
    object Label1: TLabel
      Left = 12
      Top = 31
      Width = 90
      Height = 14
      Caption = 'Valor Baixa Parcial'
    end
    object Label2: TLabel
      Left = 12
      Top = 75
      Width = 51
      Height = 14
      Caption = 'Total Geral'
    end
    object Label9: TLabel
      Left = 12
      Top = 53
      Width = 62
      Height = 14
      Caption = 'Valor Cr'#233'dito'
    end
    object edtValBaixaTotal: TEditFocus
      Tag = 99
      Left = 279
      Top = 6
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdBaixaTotal: TEditFocus
      Tag = 99
      Left = 247
      Top = 6
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtQtdBaixaParcial: TEditFocus
      Tag = 99
      Left = 247
      Top = 28
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValBaixaParcial: TEditFocus
      Tag = 99
      Left = 279
      Top = 28
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdGeral: TEditFocus
      Tag = 99
      Left = 247
      Top = 72
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValGeral: TEditFocus
      Tag = 99
      Left = 279
      Top = 72
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdCredito: TEditFocus
      Tag = 99
      Left = 247
      Top = 50
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValCredito: TEditFocus
      Tag = 99
      Left = 279
      Top = 50
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 230
    Width = 362
    Height = 98
    Align = alBottom
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    DesignSize = (
      362
      98)
    object Label3: TLabel
      Left = 12
      Top = 9
      Width = 152
      Height = 14
      Caption = 'Valor Baixa Total com Desconto'
    end
    object Label4: TLabel
      Left = 12
      Top = 31
      Width = 90
      Height = 14
      Caption = 'Valor Baixa Parcial'
    end
    object Label5: TLabel
      Left = 12
      Top = 75
      Width = 123
      Height = 14
      Caption = 'Total Geral com Desconto'
    end
    object Label10: TLabel
      Left = 12
      Top = 53
      Width = 62
      Height = 14
      Caption = 'Valor Cr'#233'dito'
    end
    object edtValBaixaTotalDesc: TEditFocus
      Tag = 99
      Left = 279
      Top = 6
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdBaixaTotal2: TEditFocus
      Tag = 99
      Left = 247
      Top = 6
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtQtdBaixaParcial2: TEditFocus
      Tag = 99
      Left = 247
      Top = 28
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValBaixaParcialDesc: TEditFocus
      Tag = 99
      Left = 279
      Top = 28
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdGeral2: TEditFocus
      Tag = 99
      Left = 247
      Top = 72
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValGeralDesc: TEditFocus
      Tag = 99
      Left = 279
      Top = 72
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdCredito2: TEditFocus
      Tag = 99
      Left = 247
      Top = 50
      Width = 31
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValCredito2: TEditFocus
      Tag = 99
      Left = 279
      Top = 50
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlDesconto: TPanel [4]
    Left = 0
    Top = 100
    Width = 362
    Height = 130
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 1
    object Label7: TLabel
      Left = 12
      Top = 46
      Width = 153
      Height = 14
      Caption = 'Desconto sobre Baixa Total (%)'
    end
    object Label8: TLabel
      Left = 12
      Top = 68
      Width = 91
      Height = 14
      Caption = 'Desconto em Valor'
    end
    object edtPerDesc: TEditFocus
      Tag = 99
      Left = 247
      Top = 43
      Width = 46
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValDesc: TEditFocus
      Tag = 99
      Left = 247
      Top = 65
      Width = 77
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
    object rgpTipDes: TRadioGroup
      Tag = 99
      Left = 12
      Top = 87
      Width = 333
      Height = 36
      Caption = ' Tipo de Desconto '
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Devolu'#231#227'o'
        'Bonifica'#231#227'o'
        'Outros')
      TabOrder = 2
    end
    object rgpDescSobre: TRadioGroup
      Tag = 99
      Left = 12
      Top = 1
      Width = 333
      Height = 36
      Caption = ' Aplicar Desconto Sobre '
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Total Geral'
        'Baixa Total')
      TabOrder = 3
      OnClick = rgpDescSobreClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 128
    Top = 290
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 290
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 160
    Top = 290
  end
end
