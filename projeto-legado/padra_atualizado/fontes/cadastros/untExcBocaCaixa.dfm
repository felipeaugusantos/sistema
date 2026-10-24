inherited frmExcBocaCaixa: TfrmExcBocaCaixa
  Height = 400
  Caption = 'Excluir Boca de Caixa'
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Height = 26
    ExplicitTop = 319
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 636
      Height = 22
      ExplicitWidth = 636
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Caption = '[F3] Muda Ordem'
      end
      object btnGravar: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 116
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
      object btnMarcaTodos: TBitBtnLocked
        Left = 347
        Top = 0
        Width = 150
        Height = 22
        Caption = '[F6] Marca/Desm. Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaTodosClick
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
    Top = 345
    ExplicitTop = 345
  end
  inherited pnlHeader: TPanel
    Visible = False
  end
  inherited pnlTail: TPanel
    Top = 271
    ExplicitTop = 271
  end
  inherited dbgConsulta: TDBGridCitel
    Height = 174
    Columns = <
      item
        Expanded = False
        FieldName = 'BCA_CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODGRU'
        Title.Alignment = taCenter
        Title.Caption = 'Grupo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BCA_CODITE'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAR_DESMAR'
        Title.Caption = 'Marca'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        Title.Alignment = taCenter
        Title.Caption = 'Unid.'
        Width = 30
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_PRECUS'
        Title.Alignment = taCenter
        Title.Caption = 'Pr. Custo'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_PREVE1'
        Title.Alignment = taCenter
        Title.Caption = 'Pr. Venda'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'BCA_PREMIN'
        Title.Alignment = taCenter
        Title.Caption = 'Pr. M'#237'nimo'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'BCA_COMVAR'
        Title.Alignment = taCenter
        Title.Caption = 'Comiss'#227'o'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AUTOINCREM'
        Title.Alignment = taCenter
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 65520
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 184
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 144
    Top = 184
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterScroll = cdsConsultaAfterScroll
    Left = 176
    Top = 184
  end
  inherited dtsConsulta: TDataSource
    Left = 208
    Top = 184
  end
end
