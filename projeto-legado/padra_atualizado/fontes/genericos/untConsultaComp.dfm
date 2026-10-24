inherited frmConsultaComp: TfrmConsultaComp
  Position = poDesigned
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 336
  end
  inherited pnlBotoes: TPanel
    inherited Label2: TLabel
      Left = 92
      Width = 597
      ExplicitLeft = 92
      ExplicitWidth = 597
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      Height = 24
      Align = alLeft
      ExplicitLeft = 3
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 691
      Top = 3
      Height = 24
      Align = alRight
      ExplicitLeft = 691
      ExplicitTop = 3
      ExplicitHeight = 24
    end
  end
  inherited Panel1: TPanel
    Top = 336
    Height = 140
    ExplicitTop = 336
    ExplicitHeight = 140
    inherited lblBuscarPor1: TLabel
      Left = 147
      ExplicitLeft = 147
    end
    inherited lblChave1: TLabel
      Left = 206
      ExplicitLeft = 206
    end
    inherited lblChave2: TLabel
      Left = 206
      ExplicitLeft = 206
    end
    inherited lblBuscarPor2: TLabel
      Left = 147
      ExplicitLeft = 147
    end
    inherited lblBuscarPor3: TLabel
      Left = 147
      ExplicitLeft = 147
    end
    inherited lblChave3: TLabel
      Left = 206
      ExplicitLeft = 206
    end
    inherited lstIndices: TListBox
      Width = 136
      Height = 121
      ExplicitWidth = 136
      ExplicitHeight = 121
    end
    inherited edtFiltro1: TEdit
      Left = 147
      Width = 360
      OnKeyPress = edtFiltro1KeyPress
      ExplicitLeft = 147
      ExplicitWidth = 360
    end
    inherited edtFiltro2: TEdit
      Left = 147
      Width = 360
      OnKeyPress = edtFiltro2KeyPress
      ExplicitLeft = 147
      ExplicitWidth = 360
    end
    inherited edtFiltro3: TEdit
      Left = 147
      Width = 362
      OnKeyPress = edtFiltro3KeyPress
      ExplicitLeft = 147
      ExplicitWidth = 362
    end
    object pnlLegendaCadCli: TPanel
      Left = 520
      Top = 40
      Width = 249
      Height = 79
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      Visible = False
      object Shape1: TShape
        Left = 16
        Top = 51
        Width = 37
        Height = 18
        Brush.Color = clRed
      end
      object Shape2: TShape
        Left = 16
        Top = 27
        Width = 37
        Height = 18
        Brush.Color = clPurple
      end
      object lblLegenda: TLabel
        Left = 16
        Top = 4
        Width = 66
        Height = 16
        Caption = 'Legenda:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPendencia: TLabel
        Left = 59
        Top = 53
        Width = 90
        Height = 13
        Caption = 'Pend'#234'ncias SCPC.'
      end
      object lblInativo: TLabel
        Left = 59
        Top = 29
        Width = 35
        Height = 13
        Caption = 'Inativo.'
      end
    end
    object btnExecutaTarefa: TBitBtnLocked
      Left = 552
      Top = 11
      Width = 217
      Height = 23
      Caption = '[ F4 ] Executa Tarefa'
      TabOrder = 4
      Visible = False
    end
    object chkConsContida: TCheckBox
      Left = 147
      Top = 122
      Width = 136
      Height = 17
      Caption = 'Utilizar consulta contida?'
      TabOrder = 6
    end
  end
end
