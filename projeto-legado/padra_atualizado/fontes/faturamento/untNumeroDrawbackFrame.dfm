object fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame
  Left = 0
  Top = 0
  Width = 497
  Height = 27
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDrawBackFrame: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 27
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object btnDrawback: TBitBtnLocked
      Left = 8
      Top = 2
      Width = 185
      Height = 25
      Caption = 'Informar o N'#250'mero do Drawback'
      TabOrder = 0
      OnClick = btnDrawbackClick
    end
  end
end
