inherited frmPnlDadosItemPrecoProduto: TfrmPnlDadosItemPrecoProduto
  ClientHeight = 39
  OnKeyDown = FormKeyDown
  ExplicitHeight = 39
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDadosItem: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 39
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlRodape: TPanel
      Left = 0
      Top = 0
      Width = 1024
      Height = 39
      Align = alClient
      ParentColor = True
      TabOrder = 0
      object btnExecutaTarefa: TBitBtnLocked
        Left = 0
        Top = 5
        Width = 209
        Height = 19
        Caption = '[ CTRL + F4 ] Composi'#231#227'o do Custo'
        TabOrder = 0
        OnClick = btnExecutaTarefaClick
      end
    end
  end
  object dtsConsulta: TDataSource
    Left = 72
    Top = 8
  end
  object popAtalhos: TPopupMenu
    Left = 944
    Top = 231
    object mnuAgregados: TMenuItem
      Caption = '[Alt + G] A&gregados'
    end
    object mnuReqCompra: TMenuItem
      Caption = '[Alt + R] &Requisi'#231#227'o de Compra'
    end
    object btnImgSite: TMenuItem
      Caption = '[Alt + F9] &Visualizar Imagem Site'
    end
  end
  object cxsGrid: TcxStyleRepository
    Left = 128
    Top = 8
    PixelsPerInch = 96
    object cxsSaldos: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsSaldosDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosML: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsSaldosCD: TcxStyle
      AssignedValues = [svColor]
      Color = 16765039
    end
    object cxsSaldosCDML: TcxStyle
      AssignedValues = [svColor]
      Color = 12713921
    end
    object cxsSaldosMLDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosCDDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16765039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsSaldosCDMLDisponivel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 12713921
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsValorDisponivel: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
  end
end
