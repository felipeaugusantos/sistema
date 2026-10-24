inherited frmBalancoEstoqueDigManualLote: TfrmBalancoEstoqueDigManualLote
  Left = 298
  Top = 208
  VertScrollBar.Range = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'Saldos de Lotes'
  ClientHeight = 549
  ClientWidth = 470
  ExplicitWidth = 476
  ExplicitHeight = 578
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 505
    Width = 470
    ExplicitTop = 505
    ExplicitWidth = 470
    DesignSize = (
      470
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 466
      ExplicitWidth = 466
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 108
        Caption = '[F3] Muda Ordem'
        ExplicitWidth = 108
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 108
        Width = 100
        ExplicitLeft = 108
        ExplicitWidth = 100
      end
      object btnIncluir: TBitBtnLocked
        Left = 208
        Top = 0
        Width = 99
        Height = 22
        Caption = '[F6] Incluir Lote'
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
        TabOrder = 2
        OnClick = btnIncluirClick
      end
      object btnGravar: TBitBtnLocked
        Left = 307
        Top = 0
        Width = 87
        Height = 22
        Caption = '[F10] Gravar'
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
        TabOrder = 3
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Width = 64
      ExplicitLeft = 404
      ExplicitTop = 2
      ExplicitWidth = 64
    end
  end
  inherited pnlStatus: TPanel
    Top = 533
    Width = 470
    Visible = False
    ExplicitTop = 533
    ExplicitWidth = 470
    inherited pnlNomeForm: TPanel
      Left = 299
      ExplicitLeft = 299
    end
    inherited pnlInfo: TPanel
      Width = 299
      ExplicitWidth = 299
    end
  end
  inherited pnlHeader: TPanel
    Width = 470
    Height = 46
    Visible = False
    ExplicitWidth = 470
    ExplicitHeight = 46
  end
  inherited pnlTail: TPanel
    Top = 473
    Width = 470
    Height = 32
    Enabled = False
    Visible = True
    ExplicitTop = 473
    ExplicitWidth = 470
    ExplicitHeight = 32
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 12
      Width = 86
      Height = 18
      Margins.Top = 12
      Margins.Bottom = 2
      Align = alLeft
      Caption = 'Saldo F'#237'sico Total:'
      ExplicitHeight = 14
    end
    object lblSldMl: TLabel
      AlignWithMargins = True
      Left = 178
      Top = 12
      Width = 124
      Height = 18
      Margins.Top = 12
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'Saldo em Grama/ML Total:'
      ExplicitHeight = 14
    end
    object shpRed: TShape
      AlignWithMargins = True
      Left = 391
      Top = 12
      Width = 17
      Height = 15
      Margins.Top = 12
      Margins.Bottom = 5
      Align = alLeft
      Brush.Color = 8421631
      Pen.Style = psClear
      ExplicitLeft = 380
      ExplicitTop = 11
    end
    object lbllegLotInativo: TLabel
      AlignWithMargins = True
      Left = 414
      Top = 12
      Width = 67
      Height = 18
      Margins.Top = 12
      Margins.Bottom = 2
      Align = alLeft
      Caption = 'Lotes inativos'
      Color = clBlack
      ParentColor = False
      ExplicitHeight = 14
    end
    object edtSalTot: TEditFocus
      AlignWithMargins = True
      Left = 95
      Top = 8
      Width = 77
      Height = 22
      Margins.Top = 8
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taRightJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSldMl: TEditFocus
      Tag = 99
      AlignWithMargins = True
      Left = 308
      Top = 8
      Width = 77
      Height = 22
      Margins.Top = 8
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '###0.0000'
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 86
    Width = 470
    Height = 387
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnEnter = dbgConsultaEnter
    OnExit = dbgConsultaExit
    Columns = <
      item
        Expanded = False
        FieldName = 'LOT_NUMLOT'
        ReadOnly = True
        Title.Caption = 'N'#250'mero do Lote'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOT_LOCFIS'
        ReadOnly = True
        Title.Caption = 'Localiza'#231#227'o F'#237'sica'
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOT_QTDCHA'
        Title.Caption = 'Qtd. Chapa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOT_PARCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo F'#237'sico'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOT_MLPCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo ( Gr/ML )'
        Width = 99
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 46
    Width = 470
    ExplicitTop = 46
    ExplicitWidth = 470
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
      Left = 299
      Top = 9
      Width = 163
      ExplicitLeft = 299
      ExplicitTop = 9
      ExplicitWidth = 163
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 280
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 136
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 144
    Top = 136
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    BeforePost = cdsConsultaBeforePost
    Left = 220
    Top = 204
    object cdsConsultaTOT_PARCON: TAggregateField
      FieldName = 'TOT_PARCON'
      Active = True
      DisplayName = ''
      Expression = 'SUM(LOT_PARCON)'
    end
    object cdsConsultaTOT_MLPCON: TAggregateField
      FieldName = 'TOT_MLPCON'
      Active = True
      DisplayName = ''
      Expression = 'SUM(LOT_MLPCON)'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 264
    Top = 140
  end
  object qryCadIte: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  ITE_CODITE,'
      '  ITE_DESITE'
      'FROM'
      '  CADITE')
    Constraints = <>
    Left = 600
    Top = 152
  end
end
