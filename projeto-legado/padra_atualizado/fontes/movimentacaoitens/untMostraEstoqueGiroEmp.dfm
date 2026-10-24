inherited frmMostraEstoqueGiroEmp: TfrmMostraEstoqueGiroEmp
  Left = 219
  Top = 419
  Width = 774
  Height = 454
  Caption = 'Estoque e Giro nas Empresas'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 383
    Width = 766
    inherited btnSair: TBitBtn
      Left = 685
    end
  end
  inherited pnlStatus: TPanel
    Top = 411
    Width = 766
    inherited pnlNomeForm: TPanel
      Left = 595
    end
    inherited pnlInfo: TPanel
      Width = 595
    end
  end
  object pnlGiroMeses: TPanel [2]
    Left = 0
    Top = 337
    Width = 766
    Height = 46
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    Visible = False
    object lblQtdM04: TLabel
      Left = 7
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM05: TLabel
      Left = 87
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM05'
      Visible = False
    end
    object lblQtdM06: TLabel
      Left = 167
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM06'
      Visible = False
    end
    object lblQtdM07: TLabel
      Left = 247
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM07'
      Visible = False
    end
    object lblQtdM08: TLabel
      Left = 327
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM08'
      Visible = False
    end
    object lblQtdM09: TLabel
      Left = 407
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM09'
      Visible = False
    end
    object lblQtdM10: TLabel
      Left = 487
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM10'
      Visible = False
    end
    object lblQtdM11: TLabel
      Left = 567
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM11'
      Visible = False
    end
    object lblQtdM12: TLabel
      Left = 647
      Top = 4
      Width = 47
      Height = 14
      Caption = 'lblQtdM12'
      Visible = False
    end
    object dbeQtdM04: TDBEditFocus
      Left = 7
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES004'
      TabOrder = 0
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM05: TDBEditFocus
      Left = 87
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES005'
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM06: TDBEditFocus
      Left = 167
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES006'
      TabOrder = 2
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM07: TDBEditFocus
      Left = 247
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES007'
      TabOrder = 3
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM08: TDBEditFocus
      Left = 327
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES008'
      TabOrder = 4
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM09: TDBEditFocus
      Left = 407
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES009'
      TabOrder = 5
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM10: TDBEditFocus
      Left = 487
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES010'
      TabOrder = 6
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM11: TDBEditFocus
      Left = 567
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES011'
      TabOrder = 7
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdM12: TDBEditFocus
      Left = 647
      Top = 17
      Width = 73
      Height = 22
      DataField = 'MES012'
      TabOrder = 8
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 0
    Width = 766
    Height = 337
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 766
      Height = 37
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 15
        Top = 15
        Width = 28
        Height = 14
        Caption = 'Item:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtItem: TEditFocus
        Left = 55
        Top = 8
        Width = 682
        Height = 22
        TabStop = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
    end
    object dbeEstoque: TDBGridCitel
      Left = 0
      Top = 37
      Width = 766
      Height = 271
      Align = alClient
      DataSource = frmModuloSPR.dtsTemporaria2
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODEMP'
          Title.Caption = 'Emp'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMEMP'
          Title.Caption = 'Nome da Empresa'
          Width = 270
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'MES001'
          Title.Alignment = taRightJustify
          Title.Caption = 'Mai/2008'
          Width = 85
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'MES002'
          Title.Alignment = taRightJustify
          Title.Caption = 'Jun/2008'
          Width = 85
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'MES003'
          Title.Alignment = taRightJustify
          Title.Caption = 'Jul/2008'
          Width = 85
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'MEDIA'
          Title.Alignment = taRightJustify
          Title.Caption = 'M'#233'dia'
          Width = 85
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SALDOS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Saldo'
          Width = 85
          Visible = True
        end>
    end
    object Panel1: TPanel
      Left = 0
      Top = 308
      Width = 766
      Height = 29
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 2
      object Label2: TLabel
        Left = 15
        Top = 8
        Width = 37
        Height = 14
        Caption = 'Totais:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSaldo: TLabel
        Left = 671
        Top = 8
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblSaldo'
      end
      object lblMes3: TLabel
        Left = 500
        Top = 8
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblMes3'
      end
      object lblMes2: TLabel
        Left = 415
        Top = 8
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblMes2'
      end
      object lblMes1: TLabel
        Left = 330
        Top = 8
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblMes1'
      end
      object lblMedia: TLabel
        Left = 586
        Top = 8
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblMedia'
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 192
  end
end
