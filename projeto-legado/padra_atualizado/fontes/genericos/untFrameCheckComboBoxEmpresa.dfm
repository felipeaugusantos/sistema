object fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa
  Left = 0
  Top = 0
  Width = 303
  Height = 31
  TabOrder = 0
  object lblEmpresa: TLabel
    Left = 3
    Top = 7
    Width = 45
    Height = 13
    Caption = 'Empresa:'
  end
  object chkcbEmpresa: TcxCheckComboBox
    Left = 52
    Top = 2
    OnFocusChanged = chkcbEmpresaFocusChanged
    AutoSize = False
    Properties.EmptySelectionText = 'Todas'
    Properties.EditValueFormat = cvfCaptions
    Properties.Items = <>
    Style.BorderStyle = ebsSingle
    Style.Color = clWindow
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.ScrollbarMode = sbmClassic
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.ScrollbarMode = sbmClassic
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.ScrollbarMode = sbmClassic
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.ScrollbarMode = sbmClassic
    TabOrder = 0
    Height = 24
    Width = 247
  end
end
