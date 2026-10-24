inherited frmPedeFonteLinhaMatricial: TfrmPedeFonteLinhaMatricial
  Width = 395
  Height = 114
  Caption = 'Selecione a fonte de impress'#227'o'
  ExplicitWidth = 395
  ExplicitHeight = 114
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 42
    Width = 389
    ExplicitTop = 42
    ExplicitWidth = 389
    inherited btnSair: TBitBtnLocked
      Left = 306
      ExplicitLeft = 306
    end
  end
  inherited pnlStatus: TPanel
    Top = 70
    Width = 389
    ExplicitTop = 70
    ExplicitWidth = 389
    inherited pnlNomeForm: TPanel
      Left = 218
      ExplicitLeft = 218
    end
    inherited pnlInfo: TPanel
      Width = 218
      ExplicitWidth = 218
    end
  end
  object cxvFonte: TcxVerticalGrid [2]
    Left = 0
    Top = 0
    Width = 389
    Height = 42
    Align = alClient
    OptionsView.RowHeaderWidth = 102
    OptionsBehavior.GoToNextCellOnEnter = True
    OptionsBehavior.GoToNextCellOnTab = True
    TabOrder = 2
    Version = 1
    object cxvFonteTamanho: TcxEditorRow
      Properties.Caption = 'Tamanho'
      Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
      Properties.EditProperties.DropDownListStyle = lsFixedList
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.Items.Strings = (
        '39 Colunas (Expandido)'
        '79 Colunas (10 cpi)'
        '95 Colunas'
        '136 Colunas'
        '159 Colunas')
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
  end
end
