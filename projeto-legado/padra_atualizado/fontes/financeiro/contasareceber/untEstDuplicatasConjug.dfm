inherited frmEstDuplicatasConjug: TfrmEstDuplicatasConjug
  Left = 229
  Top = 281
  Width = 657
  Height = 324
  BorderIcons = [biSystemMenu]
  Caption = 'Duplicatas Conjugadas que tamb'#233'm ser'#227'o estornadas:'
  Position = poMainFormCenter
  ExplicitWidth = 657
  ExplicitHeight = 324
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 245
    Width = 651
    Height = 31
    ExplicitTop = 245
    ExplicitWidth = 651
    ExplicitHeight = 31
    DesignSize = (
      651
      31)
    object lblLegenda: TLabel [0]
      Left = 88
      Top = 1
      Width = 401
      Height = 28
      Caption = 
        'Duplicatas marcadas: duplicata principal n'#227'o existe ou ainda est' +
        #225' baixada.'#13#10#201' necess'#225'rio estornar as duplicatas principais prime' +
        'iro.'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 569
      Top = 5
      TabOrder = 1
      ExplicitLeft = 569
      ExplicitTop = 5
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 77
      Height = 22
      Caption = '&Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 276
    Width = 651
    ExplicitTop = 276
    ExplicitWidth = 651
    inherited pnlNomeForm: TPanel
      Left = 480
      ExplicitLeft = 480
    end
    inherited pnlInfo: TPanel
      Width = 480
      ExplicitWidth = 480
    end
  end
  object dbgGrid: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 651
    Height = 245
    Align = alClient
    DataSource = dtsGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgGridDrawColumnCell
    OnKeyDown = dbgGridKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMDUP'
        Title.Caption = 'Nro Duplicata'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SEQBAI'
        Title.Caption = 'Seq. Baixa'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTACAD'
        Title.Caption = 'Data Cadastro'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCLI'
        Title.Caption = 'Cliente'
        Width = 335
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALDOC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 75
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 88
  end
  object dtsGrid: TDataSource
    DataSet = cdsGrid
    Left = 448
    Top = 88
  end
  object qryGrid: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    SQL.Strings = (
      'SELECT '
      'CONCAT(RCX_NUMDOC, "-", RCX_ESPDOC) AS NUMDUP,'
      'RCX_DTACAD AS DTACAD,'
      'CONCAT(RCX_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,'
      'RCX_VALDOC AS VALDOC'
      'FROM '
      'CADRCXX'
      'JOIN CADCLI ON (RCX_CODCLI=CLI_CODCLI)'
      'LIMIT 1')
    Params = <>
    Left = 352
    Top = 88
  end
  object cdsGrid: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGrid'
    Left = 416
    Top = 88
  end
  object dspGrid: TUniDataSetProvider
    DataSet = qryGrid
    Left = 384
    Top = 88
  end
end
