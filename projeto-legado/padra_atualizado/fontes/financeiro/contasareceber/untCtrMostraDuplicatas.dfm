inherited frmCtrMostraDuplicatas: TfrmCtrMostraDuplicatas
  Left = 245
  Top = 194
  Width = 697
  Height = 324
  Caption = 'Duplicatas'
  Position = poMainFormCenter
  ExplicitWidth = 697
  ExplicitHeight = 324
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 252
    Width = 691
    ExplicitTop = 252
    ExplicitWidth = 691
    DesignSize = (
      691
      28)
    inherited btnSair: TBitBtnLocked
      Left = 608
      ExplicitLeft = 608
    end
    object btnProdutos: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 127
      Height = 22
      Caption = '[ F7 ] - Produtos'
      TabOrder = 1
      OnClick = btnProdutosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 280
    Width = 691
    ExplicitTop = 280
    ExplicitWidth = 691
    inherited pnlNomeForm: TPanel
      Left = 520
      ExplicitLeft = 520
    end
    inherited pnlInfo: TPanel
      Width = 520
      ExplicitWidth = 520
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 236
    Width = 691
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Panel3: TPanel
      Left = 520
      Top = 0
      Width = 171
      Height = 16
      Align = alRight
      BevelInner = bvLowered
      PopupMenu = PopupMenu1
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 520
      Height = 16
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
    end
  end
  object dbgDuplicatas: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 691
    Height = 236
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_NUMDUP'
        ImeName = 'CTR_NUMDUP'
        Title.Caption = 'Duplicata'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_ESPDOC'
        ImeName = 'CTR_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Caption = 'Emp.'
        Width = 36
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 244
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_CODVEL'
        Title.Caption = 'Doc.Antigo'
        Width = 69
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Alignment = taRightJustify
        Title.Caption = 'Data Cadastro'
        Width = 74
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vencimento'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_VALDUP'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Visible = True
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 80
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
end
