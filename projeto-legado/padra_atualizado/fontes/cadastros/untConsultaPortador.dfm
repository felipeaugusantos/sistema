inherited frmConsultaPortador: TfrmConsultaPortador
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel [0]
    Left = 568
    Top = 97
    Width = 179
    Height = 13
    Caption = 'Portadores que permitem baixa.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel1: TPanel
    object shpPorBai: TShape [7]
      Left = 553
      Top = 95
      Width = 12
      Height = 11
      Brush.Color = clBlue
    end
    object lblPorPer: TLabel [8]
      Left = 568
      Top = 94
      Width = 150
      Height = 13
      Caption = 'Portadores com Permiss'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPorSPe: TLabel [9]
      Left = 568
      Top = 110
      Width = 149
      Height = 13
      Caption = 'Portadores sem Permiss'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
