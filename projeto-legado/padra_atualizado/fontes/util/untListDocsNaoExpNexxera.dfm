inherited frmListDocsNaoExpNexxera: TfrmListDocsNaoExpNexxera
  Left = 314
  Top = 215
  Width = 725
  Height = 400
  BorderIcons = [biSystemMenu]
  Caption = 
    'Exporta'#231#227'o do Arquivo Faturamento - Nexxera (Documentos que N'#195'O ' +
    'ir'#227'o ser exportados)'
  ExplicitWidth = 725
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Width = 709
    Height = 26
    ExplicitTop = 319
    ExplicitWidth = 709
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 587
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 705
      inherited btnPesquisar: TBitBtnLocked
        Width = 118
        ExplicitWidth = 118
      end
      object btnConfirma: TBitBtnLocked
        Left = 236
        Top = 0
        Width = 118
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
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 589
      Top = 2
      Width = 118
      Align = alRight
      ExplicitLeft = 595
      ExplicitWidth = 118
    end
  end
  inherited pnlHeader: TPanel
    Width = 709
    Height = 90
    Visible = False
    ExplicitWidth = 709
    ExplicitHeight = 90
    object lblCodEmp: TLabel
      Left = 386
      Top = 8
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object lbl1: TLabel
      Left = 8
      Top = 46
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
    end
    object lblDtaIni: TLabel
      Left = 8
      Top = 8
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 79
      Top = 8
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 386
      Top = 22
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 457
      Top = 22
      Width = 250
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 8
      Top = 60
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 79
      Top = 60
      Width = 250
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 70
      Height = 22
      TabStop = False
      EditMask = '99/99/9999'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 79
      Top = 22
      Width = 70
      Height = 22
      TabStop = False
      EditMask = '99/99/9999'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlTail: TPanel
    Top = 271
    Width = 709
    ExplicitTop = 269
    ExplicitWidth = 709
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 130
    Width = 709
    Height = 141
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TitleFont.Height = -11
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp'#233'cie'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Empresa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODCLI'
        Title.Caption = 'C'#243'd. Cliente'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        Title.Caption = 'Nome Cliente'
        Width = 266
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Doc.'
        Width = 90
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 90
    Width = 709
    ExplicitTop = 90
    ExplicitWidth = 709
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
  inherited pnlStatus: TPanel
    Top = 345
    Width = 709
    ExplicitTop = 345
    ExplicitWidth = 709
    inherited pnlNomeForm: TPanel
      Left = 538
      ExplicitLeft = 538
    end
    inherited pnlInfo: TPanel
      Width = 538
      ExplicitWidth = 538
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 200
  end
  inherited qryConsulta: TUniQuery
    Left = 504
    Top = 200
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 536
    Top = 200
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 568
    Top = 200
  end
  inherited dtsConsulta: TDataSource
    Left = 600
    Top = 200
  end
end
