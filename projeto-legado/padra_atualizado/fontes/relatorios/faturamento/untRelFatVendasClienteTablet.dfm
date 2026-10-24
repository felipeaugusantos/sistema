inherited frmRelFatVendasClienteTablet: TfrmRelFatVendasClienteTablet
  Width = 620
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = 'Movimenta'#231#227'o de Clientes'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 620
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  object Label12: TLabel [0]
    Left = 174
    Top = 7
    Width = 118
    Height = -10
    Alignment = taRightJustify
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Total Produtos:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 180
    ExplicitHeight = 19
  end
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 614
    ExplicitTop = 427
    ExplicitWidth = 614
    inherited FlwBotoes: TFlowPanel
      Width = 610
    end
    inherited btnSair: TBitBtnLocked
      Left = 531
      ExplicitLeft = 531
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 614
    Height = 427
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlCliente: TPanel
      Left = 1
      Top = 1
      Width = 612
      Height = 28
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object shpCliente: TShape
        Left = 1
        Top = 1
        Width = 610
        Height = 26
        Align = alClient
        Brush.Color = clMoneyGreen
        Shape = stRoundRect
        ExplicitLeft = 16
        ExplicitTop = 8
        ExplicitWidth = 65
        ExplicitHeight = 65
      end
      object lblCliente: TLabel
        Left = 8
        Top = 5
        Width = 59
        Height = 19
        Caption = 'Cliente:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
    end
    object pnlMovimento: TPanel
      Left = 1
      Top = 29
      Width = 612
      Height = 145
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object shpMovimento: TShape
        Left = 1
        Top = 1
        Width = 610
        Height = 143
        Align = alClient
        Brush.Color = clMoneyGreen
        Shape = stRoundRect
        ExplicitLeft = 16
        ExplicitTop = 8
        ExplicitWidth = 65
        ExplicitHeight = 65
      end
      object dbgDados: TDBGridCitel
        Left = 10
        Top = 2
        Width = 600
        Height = 140
        BorderStyle = bsNone
        Color = clMoneyGreen
        Ctl3D = False
        DataSource = dtsRelVenCli
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -21
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = [fsBold]
        StyleElements = []
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CODITE'
            Title.Caption = 'C'#243'd.'
            Title.Color = clNavy
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Title.Color = clNavy
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 251
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QTDITE'
            Title.Alignment = taRightJustify
            Title.Caption = 'Qtde.'
            Title.Color = clNavy
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNITAR'
            Title.Alignment = taRightJustify
            Title.Caption = 'Vr. Unit.'
            Title.Color = clNavy
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTITE'
            Title.Alignment = taRightJustify
            Title.Caption = 'Vr. Total'
            Title.Color = clNavy
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = [fsBold]
            Width = 90
            Visible = True
          end>
      end
    end
    object pnlTotais: TPanel
      Left = 1
      Top = 174
      Width = 612
      Height = 86
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      DesignSize = (
        612
        86)
      object Shape1: TShape
        Left = 1
        Top = 1
        Width = 610
        Height = 84
        Align = alClient
        Brush.Color = clMoneyGreen
        Shape = stRoundRect
        ExplicitLeft = 0
        ExplicitTop = 0
      end
      object lblTitDesESp: TLabel
        Left = 430
        Top = 59
        Width = 87
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Desc. Esp.:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label8: TLabel
        Left = 222
        Top = 7
        Width = 118
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Total Produtos:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label13: TLabel
        Left = 274
        Top = 33
        Width = 66
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Total IPI:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label14: TLabel
        Left = 254
        Top = 59
        Width = 86
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Valor Total:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 36
        Top = 7
        Width = 70
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Dta. Ent.:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 11
        Top = 33
        Width = 95
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Documento:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 6
        Top = 59
        Width = 100
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Doc. Origem:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object edtTotIte: TEditFocus
        Tag = 99
        Left = 341
        Top = 2
        Width = 80
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotIpi: TEditFocus
        Tag = 99
        Left = 341
        Top = 28
        Width = 80
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValTot: TEditFocus
        Tag = 99
        Left = 341
        Top = 54
        Width = 80
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesEsp: TEditFocus
        Tag = 99
        Left = 518
        Top = 54
        Width = 80
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDtaEnt: TEditFocus
        Tag = 99
        Left = 108
        Top = 2
        Width = 110
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 108
        Top = 28
        Width = 139
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDocOri: TEditFocus
        Tag = 99
        Left = 108
        Top = 54
        Width = 139
        Height = 26
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlAdicionais: TPanel
      Left = 1
      Top = 260
      Width = 612
      Height = 166
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      DesignSize = (
        612
        166)
      object shpAdicionais: TShape
        Left = 1
        Top = 1
        Width = 610
        Height = 164
        Align = alClient
        Brush.Color = clMoneyGreen
        Shape = stRoundRect
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 148
      end
      object Label4: TLabel
        Left = 10
        Top = 3
        Width = 144
        Height = 19
        Caption = 'Descr. do Produto:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 10
        Top = 30
        Width = 52
        Height = 19
        Caption = 'Marca:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 10
        Top = 56
        Width = 89
        Height = 19
        Caption = 'Mensagem:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 10
        Top = 108
        Width = 124
        Height = 19
        Caption = 'Transportadora:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lbl1: TLabel
        Left = 10
        Top = 134
        Width = 140
        Height = 19
        Caption = 'Formas de Pagto.:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblCndPag: TLabel
        Left = 343
        Top = 112
        Width = 101
        Height = 19
        Caption = 'Cond. Pagto:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblNumLot: TLabel
        Left = 458
        Top = 30
        Width = 40
        Height = 19
        Caption = 'Lote:'
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object edtDesItem: TEditFocus
        Tag = 99
        Left = 157
        Top = 2
        Width = 441
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesMarca: TEditFocus
        Tag = 99
        Left = 157
        Top = 28
        Width = 297
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtMens001: TEditFocus
        Tag = 99
        Left = 157
        Top = 54
        Width = 441
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtMens002: TEditFocus
        Tag = 99
        Left = 157
        Top = 80
        Width = 441
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTransp: TEditFocus
        Tag = 99
        Left = 157
        Top = 106
        Width = 185
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtFormas: TEditFocus
        Tag = 99
        Left = 157
        Top = 132
        Width = 441
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 449
        Top = 106
        Width = 39
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtCndPgto: TEditFocus
        Tag = 99
        Left = 488
        Top = 106
        Width = 110
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtNumLot: TEditFocus
        Tag = 99
        Left = 499
        Top = 28
        Width = 99
        Height = 29
        Alignment = taLeftJustify
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        CharCase = ecUpperCase
        Ctl3D = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 614
    ExplicitTop = 455
    ExplicitWidth = 614
    inherited pnlNomeForm: TPanel
      Left = 443
      ExplicitLeft = 443
    end
    inherited pnlInfo: TPanel
      Width = 443
      ExplicitWidth = 443
    end
  end
  object dtsRelVenCli: TDataSource
    DataSet = cdsRelVenCli
    Left = 200
  end
  object cdsRelVenCli: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    object cdsRelVenCliCODITE: TStringField
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsRelVenCliDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsRelVenCliQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsRelVenCliUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsRelVenCliTOTITE: TFloatField
      FieldName = 'TOTITE'
    end
    object cdsRelVenCliTOTCUS: TFloatField
      FieldName = 'TOTCUS'
    end
    object cdsRelVenCliMARGEM: TFloatField
      FieldName = 'MARGEM'
    end
    object cdsRelVenCliDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 50
    end
    object cdsRelVenCliMEN001: TStringField
      FieldName = 'MEN001'
      Size = 100
    end
    object cdsRelVenCliMEN002: TStringField
      FieldName = 'MEN002'
      Size = 100
    end
    object cdsRelVenCliTRANSP: TStringField
      FieldName = 'TRANSP'
      Size = 100
    end
    object cdsRelVenCliCNDCOD: TStringField
      FieldName = 'CNDCOD'
      Size = 3
    end
    object cdsRelVenCliNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 15
    end
    object cdsRelVenCliDOCORI: TStringField
      FieldName = 'DOCORI'
      Size = 15
    end
    object cdsRelVenCliNUMLOT: TStringField
      FieldName = 'NUMLOT'
      Size = 10
    end
    object cdsRelVenCliDOCUME: TStringField
      FieldName = 'DOCUME'
      Size = 15
    end
    object cdsRelVenCliESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 10
    end
    object cdsRelVenCliCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsRelVenCliCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsRelVenCliCNDFAT: TStringField
      FieldName = 'CNDFAT'
      Size = 100
    end
    object cdsRelVenCliDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsRelVenCliDESESP: TFloatField
      FieldName = 'DESESP'
    end
    object cdsRelVenCliTOTIPI: TFloatField
      FieldName = 'TOTIPI'
    end
    object cdsRelVenCliTOTGER: TFloatField
      FieldName = 'TOTGER'
    end
  end
end
