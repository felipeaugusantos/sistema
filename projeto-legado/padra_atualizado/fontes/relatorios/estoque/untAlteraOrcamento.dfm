inherited frmAlteraOrcamento: TfrmAlteraOrcamento
  Left = 263
  Top = 441
  Width = 800
  Height = 417
  Caption = 'Altera'#231#227'o de Or'#231'amento - Itens'
  ExplicitWidth = 800
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 313
    Width = 784
    Height = 49
    ExplicitTop = 313
    ExplicitWidth = 784
    ExplicitHeight = 49
    object Label1: TLabel [0]
      Left = 6
      Top = 29
      Width = 269
      Height = 14
      Caption = 'Altera'#231#227'o - permitida somente para a Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 703
      Height = 45
      ExplicitWidth = 703
      ExplicitHeight = 45
      inherited btnMudaOrdem: TBitBtnLocked
        Caption = '[ F3 ] &Muda Ordem'
      end
      inherited btnPesquisar: TBitBtnLocked
        Width = 103
        ExplicitWidth = 103
      end
      object btnGravar: TBitBtnLocked
        Left = 221
        Top = 0
        Width = 105
        Height = 22
        Caption = '[ F10 ] &Confirma'
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
      object btnAlterar: TBitBtnLocked
        Left = 326
        Top = 0
        Width = 113
        Height = 22
        Caption = '[ ENTER ] &Alterar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
          055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
          005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
          B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
          305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
          305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
          30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
          3055577777555557F7F555000555555999555577755555577755}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnAlterarClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 439
        Top = 0
        Width = 99
        Height = 22
        Caption = '[ DEL ] &Excluir'
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
        TabOrder = 4
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Height = 45
      Align = alRight
      Caption = 'Ca&ncela'
      ExplicitLeft = 705
      ExplicitTop = 2
      ExplicitHeight = 45
    end
  end
  inherited pnlHeader: TPanel
    Width = 784
    Height = 30
    Visible = False
    ExplicitWidth = 784
    ExplicitHeight = 30
  end
  inherited pnlTail: TPanel
    Top = 268
    Width = 784
    Height = 45
    ExplicitTop = 268
    ExplicitWidth = 784
    ExplicitHeight = 45
    object Label2: TLabel
      Left = 320
      Top = 0
      Width = 146
      Height = 18
      Caption = 'Aguarde, gravando...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object prbProgesso: TcxProgressBar
      Left = 0
      Top = 23
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 15
      Width = 784
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 70
    Width = 784
    Height = 198
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'FDO_CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'd. Item'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FDO_DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 227
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        ReadOnly = True
        Title.Caption = 'Unid.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDCD'
        ReadOnly = True
        Title.Caption = 'Saldo CD'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SALDOS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo'
        Width = 74
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ESTMIN'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Est. Minimo'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MLTCOM'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'M'#250'lt.Compra'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FDO_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant.'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FDO_UNITAR'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FDO_TOTITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 70
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 30
    Width = 784
    ExplicitTop = 30
    ExplicitWidth = 784
  end
  inherited pnlStatus: TPanel
    Top = 362
    Width = 784
    ExplicitTop = 362
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
end
