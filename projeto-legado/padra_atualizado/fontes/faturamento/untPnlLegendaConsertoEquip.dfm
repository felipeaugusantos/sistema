object frmPnlLegendaConsertoEquip: TfrmPnlLegendaConsertoEquip
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 95
  ClientWidth = 939
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDadosCliente: TPanel
    Left = 0
    Top = 0
    Width = 939
    Height = 95
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object btnGerarPDF: TBitBtnLocked
      Left = 2
      Top = 0
      Width = 100
      Height = 23
      Caption = '[ F8 ] - Gerar PDF'
      TabOrder = 0
      OnClick = btnGerarPDFClick
    end
    object btnEnviarEmail: TBitBtnLocked
      Left = 102
      Top = 0
      Width = 110
      Height = 23
      Caption = '[ F9 ] - Enviar email'
      TabOrder = 1
      OnClick = btnEnviarEmailClick
    end
    object pnlLegenda: TPanel
      Left = 776
      Top = 0
      Width = 163
      Height = 95
      Align = alRight
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 2
      object pnlLegendaCadCli: TPanel
        Left = 5
        Top = 5
        Width = 153
        Height = 85
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object shpVencido: TShape
          Left = 11
          Top = 51
          Width = 37
          Height = 18
          Brush.Color = clRed
        end
        object shpAVencer: TShape
          Left = 11
          Top = 27
          Width = 37
          Height = 18
          Brush.Color = clGreen
        end
        object lblLegenda: TLabel
          Left = 11
          Top = 4
          Width = 74
          Height = 16
          Caption = 'Legendas:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPendencia: TLabel
          Left = 54
          Top = 53
          Width = 67
          Height = 13
          Caption = 'Prazo Vencido'
        end
        object lblInativo: TLabel
          Left = 54
          Top = 29
          Width = 72
          Height = 13
          Caption = 'Prazo a Vencer'
        end
      end
    end
    object btnSituacaoEquipamento: TBitBtnLocked
      Left = 212
      Top = 0
      Width = 235
      Height = 23
      Caption = '[ F7 ] - Atualizar Situa'#231#227'o dos Equipamentos'
      TabOrder = 3
      OnClick = btnSituacaoEquipamentoClick
    end
  end
end
