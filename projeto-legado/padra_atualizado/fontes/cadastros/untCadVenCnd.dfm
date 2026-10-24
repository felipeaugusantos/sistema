inherited frmCadVenCnd: TfrmCadVenCnd
  Width = 736
  Height = 357
  Caption = 'Cadastro de Condi'#231#227'o de Pagamento por Vendedor'
  OnClose = FormClose
  ExplicitWidth = 736
  ExplicitHeight = 357
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 274
    Width = 720
    ExplicitTop = 274
    ExplicitWidth = 720
    DesignSize = (
      720
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 716
      ExplicitWidth = 716
      inherited btnPesquisar: TBitBtnLocked
        Width = 118
        ExplicitWidth = 118
      end
      object btnConfirma: TBitBtnLocked
        Left = 236
        Top = 0
        Width = 118
        Height = 22
        Caption = '[F10] Confirma'
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
      object btnExcluir: TBitBtnLocked
        Left = 354
        Top = 0
        Width = 118
        Height = 22
        Caption = '&Excluir [DELETE]'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 640
      Top = 2
      ExplicitLeft = 640
      ExplicitTop = 2
    end
  end
  inherited pnlHeader: TPanel
    Width = 720
    Height = 65
    ExplicitWidth = 720
    ExplicitHeight = 65
    object Label3: TLabel
      Left = 46
      Top = 16
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label8: TLabel
      Left = 8
      Top = 37
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pagamento:'
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 99
      Top = 8
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 138
      Top = 8
      Width = 527
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCnd: TEditFocus
      Tag = 99
      Left = 99
      Top = 32
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 138
      Top = 32
      Width = 527
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      ReadOnly = True
      TabOrder = 3
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlTail: TPanel
    Top = 226
    Width = 720
    ExplicitTop = 226
    ExplicitWidth = 720
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 105
    Width = 720
    Height = 121
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CND_CODCND'
        Title.Caption = 'C'#243'digo'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CND_CNDPAG'
        Title.Caption = 'Condi'#231#227'o'
        Width = 611
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 65
    Width = 720
    ExplicitTop = 65
    ExplicitWidth = 720
  end
  inherited pnlStatus: TPanel
    Top = 302
    Width = 720
    ExplicitTop = 302
    ExplicitWidth = 720
    inherited pnlNomeForm: TPanel
      Left = 549
      ExplicitLeft = 549
    end
    inherited pnlInfo: TPanel
      Width = 549
      ExplicitWidth = 549
    end
  end
  inherited cdsConsulta: TUniClientDataSet
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaCND_CODCND: TStringField
      FieldName = 'CND_CODCND'
      Size = 3
    end
    object cdsConsultaCND_CODEMP: TStringField
      FieldName = 'CND_CODEMP'
      Size = 3
    end
    object cdsConsultaCND_CODVEN: TStringField
      FieldName = 'CND_CODVEN'
      Size = 3
    end
    object cdsConsultaCND_CNDPAG: TStringField
      FieldName = 'CND_CNDPAG'
      ProviderFlags = []
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      Size = 100
    end
  end
end
