inherited frmFatCancelamentoManifestoEletronico: TfrmFatCancelamentoManifestoEletronico
  Height = 366
  Caption = 'Cancelamento de manifesto eletr'#244'nico'
  ExplicitHeight = 366
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 285
    Height = 26
    ExplicitTop = 285
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 638
      Height = 22
      ExplicitTop = 2
      inherited btnPesquisar: TBitBtnLocked
        Width = 102
        ExplicitWidth = 102
      end
      object btnGravar: TBitBtnLocked
        Left = 220
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
      Left = 640
      Top = 2
      Width = 75
      Align = alRight
      ExplicitTop = 2
      ExplicitWidth = 75
    end
  end
  inherited pnlHeader: TPanel
    Height = 35
    ExplicitHeight = 35
    object Label7: TLabel
      Left = 7
      Top = 11
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Manifesto:'
    end
    object edtNumMan: TEditFocus
      Tag = 99
      Left = 121
      Top = 6
      Width = 63
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
  end
  inherited pnlTail: TPanel
    Top = 237
    ExplicitTop = 235
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 75
    Height = 162
    TabStop = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAMAN'
        Title.Caption = 'Data Maif.'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJDE'
        Title.Caption = 'Destinat'#225'rio'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMDES'
        Title.Caption = 'Nome destinat'#225'rio'
        Width = 217
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor documento'
        Width = 147
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 35
    ExplicitTop = 35
  end
  inherited pnlStatus: TPanel
    Top = 311
    ExplicitTop = 311
  end
end
