inherited frmConfigLinhaGrupoSped: TfrmConfigLinhaGrupoSped
  Width = 573
  Height = 437
  VertScrollBar.Visible = False
  BiDiMode = bdRightToLeftNoAlign
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o de Linha/Grupo'
  ParentBiDiMode = False
  ExplicitWidth = 573
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 364
    Width = 567
    TabOrder = 2
    ExplicitTop = 364
    ExplicitWidth = 567
    inherited FlwBotoes: TFlowPanel
      Width = 563
      ExplicitWidth = 563
    end
    inherited btnSair: TBitBtnLocked
      Left = 484
      TabOrder = 2
      ExplicitLeft = 484
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 77
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
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 392
    Width = 567
    TabOrder = 3
    ExplicitTop = 392
    ExplicitWidth = 567
    inherited pnlNomeForm: TPanel
      Left = 396
      ExplicitLeft = 396
    end
    inherited pnlInfo: TPanel
      Width = 396
      ExplicitWidth = 396
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 567
    Height = 129
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object Label9: TLabel
      Left = 6
      Top = 6
      Width = 121
      Height = 14
      Caption = 'Linha / Grupo a Excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 46
      Width = 49
      Height = 14
      Caption = 'Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 84
      Width = 87
      Height = 14
      Caption = 'Tipo Exporta'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDesGrupo: TEditFocus
      Left = 62
      Top = 22
      Width = 387
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 323
      Top = 101
      Width = 62
      Height = 22
      Caption = 'Adicionar'
      TabOrder = 5
      OnClick = btnAdicionarClick
    end
    object btnRemover: TBitBtnLocked
      Left = 387
      Top = 101
      Width = 62
      Height = 22
      Caption = 'Remover'
      TabOrder = 6
      OnClick = btnRemoverClick
    end
    object edtCodEmp: TEditFocus
      Left = 6
      Top = 59
      Width = 55
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmp: TEditFocus
      Left = 62
      Top = 59
      Width = 387
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbTipExp: TComboBox
      Left = 6
      Top = 100
      Width = 147
      Height = 22
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 4
      Text = 'Sped Fiscal (1)'
      Items.Strings = (
        'Sped Fiscal (1)'
        'Sintegra (2)'
        'ContMatic (3)'
        'Prosoft (4)'
        'CAT42 (5)'
        'Sped Contribui'#231#245'es (6)')
    end
    object mskLinhaGrupo: TMaskEditFocus
      Left = 6
      Top = 22
      Width = 52
      Height = 22
      BiDiMode = bdLeftToRight
      EditMask = '999.999;0;_'
      MaxLength = 7
      ParentBiDiMode = False
      TabOrder = 0
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnl2: TPanel [3]
    Left = 0
    Top = 129
    Width = 567
    Height = 235
    Align = alClient
    BiDiMode = bdRightToLeftNoAlign
    ParentBiDiMode = False
    ParentColor = True
    TabOrder = 1
    object dbgrd: TDBGridCitel
      Left = 1
      Top = 1
      Width = 565
      Height = 233
      Align = alClient
      BiDiMode = bdLeftToRight
      DataSource = dsAux
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentBiDiMode = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'LGS_CODGRU'
          Title.Caption = 'Linha/Grupo'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LGS_DESGRU'
          Title.Caption = 'Descri'#231#227'o'
          Width = 280
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LGS_CODEMP'
          Title.Caption = 'Empresa'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LGS_TIPEXP'
          Title.Caption = 'Tipo Exporta'#231#227'o'
          Width = 85
          Visible = True
        end>
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 80
  end
  object dsAux: TDataSource
    Left = 512
    Top = 80
  end
end
