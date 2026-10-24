inherited frmPedeFonteMatricial: TfrmPedeFonteMatricial
  Width = 210
  Height = 253
  Caption = 'Configure a fonte do texto'
  ExplicitWidth = 210
  ExplicitHeight = 253
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 181
    Width = 204
    ExplicitTop = 181
    ExplicitWidth = 204
    inherited btnSair: TBitBtnLocked
      Left = 123
      ExplicitLeft = 123
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 209
    Width = 204
    ExplicitTop = 209
    ExplicitWidth = 204
    inherited pnlNomeForm: TPanel
      Left = 33
      ExplicitLeft = 33
    end
    inherited pnlInfo: TPanel
      Width = 33
      ExplicitWidth = 33
    end
  end
  object cxvFonte: TcxVerticalGrid [2]
    Left = 0
    Top = 0
    Width = 204
    Height = 181
    Align = alClient
    OptionsView.RowHeaderWidth = 102
    OptionsBehavior.GoToNextCellOnEnter = True
    OptionsBehavior.GoToNextCellOnTab = True
    TabOrder = 2
    Version = 1
    object cxvFonteNegrito: TcxEditorRow
      Properties.Caption = 'Negrito'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxvFonteItalico: TcxEditorRow
      Properties.Caption = 'It'#225'lico'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxvFonteSuperScript: TcxEditorRow
      Properties.Caption = 'Sobrescript'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.OnChange = cxvFonteSuperScriptEditPropertiesChange
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 2
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxvFonteSubScript: TcxEditorRow
      Properties.Caption = 'Subscript'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.OnChange = cxvFonteSubScriptEditPropertiesChange
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 3
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxvFonteCondensado: TcxEditorRow
      Properties.Caption = 'Condensado'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.OnChange = cxvFonteCondensadoEditPropertiesChange
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 4
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxvFonteExpandido: TcxEditorRow
      Properties.Caption = 'Expandido'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.OnChange = cxvFonteExpandidoEditPropertiesChange
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 5
      ParentID = -1
      Index = 5
      Version = 1
    end
    object cxvFonte12Cpi: TcxEditorRow
      Properties.Caption = '12 cpi'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.OnChange = cxvFonte12CpiEditPropertiesChange
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 6
      ParentID = -1
      Index = 6
      Version = 1
    end
    object cxvFonte15cpi: TcxEditorRow
      Properties.Caption = '15 cpi'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.OnChange = cxvFonte15cpiEditPropertiesChange
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      ID = 7
      ParentID = -1
      Index = 7
      Version = 1
    end
    object cxvFonteWide: TcxEditorRow
      Properties.Caption = 'Grande'
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = 'False'
      ID = 8
      ParentID = -1
      Index = 8
      Version = 1
    end
  end
end
