inherited frmVerItensNFCompra: TfrmVerItensNFCompra
  Left = 208
  Top = 234
  Width = 924
  Height = 443
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = 'Itens do Documento'
  Position = poScreenCenter
  ExplicitWidth = 924
  ExplicitHeight = 443
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 362
    Width = 908
    Height = 26
    TabOrder = 1
    ExplicitTop = 362
    ExplicitWidth = 908
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 904
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 827
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 829
      Top = 2
      Height = 24
      ExplicitLeft = 829
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 908
    Height = 362
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'Item'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 315
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMLOT'
        Title.Caption = 'Lote'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESMAR'
        Title.Caption = 'Marca'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODFAB'
        Title.Caption = 'C'#243'digo de F'#225'brica'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGUNI'
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 35
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 89
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 388
    Width = 908
    TabOrder = 2
    ExplicitTop = 388
    ExplicitWidth = 908
    inherited pnlNomeForm: TPanel
      Left = 737
      ExplicitLeft = 737
    end
    inherited pnlInfo: TPanel
      Width = 737
      ExplicitWidth = 737
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 152
  end
  object dtsItens: TDataSource
    Left = 576
    Top = 208
  end
end
