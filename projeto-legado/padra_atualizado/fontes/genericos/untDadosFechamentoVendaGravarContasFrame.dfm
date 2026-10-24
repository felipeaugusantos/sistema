object fraDadosFechamentoVendaGravarContasFrame: TfraDadosFechamentoVendaGravarContasFrame
  Left = 0
  Top = 0
  Width = 483
  Height = 19
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 483
    Height = 18
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 517
    object ckbOFGravaCTP: TCheckBox
      Left = 16
      Top = 2
      Width = 241
      Height = 16
      Caption = 'Gravar Contas a Pagar'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      Visible = False
    end
    object ckbGravaCTR: TCheckBox
      Left = 280
      Top = 2
      Width = 241
      Height = 16
      Caption = 'Gravar Contas a Receber'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      Visible = False
    end
  end
end
