inherited frmPedeDadosCampo: TfrmPedeDadosCampo
  Width = 1024
  Height = 737
  BorderStyle = bsSizeable
  Caption = 'Defini'#231#227'o do Campo'
  ExplicitWidth = 1024
  ExplicitHeight = 737
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 654
    Width = 1008
    ExplicitTop = 654
    ExplicitWidth = 1008
    DesignSize = (
      1008
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 925
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 682
    Width = 1008
    ExplicitTop = 682
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 654
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    TabStop = False
    object tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 622
        Align = alClient
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          1000
          622)
        object Label1: TLabel
          Left = 16
          Top = 10
          Width = 33
          Height = 14
          Caption = 'Campo'
        end
        object Label2: TLabel
          Left = 16
          Top = 48
          Width = 49
          Height = 14
          Caption = 'Descri'#231#227'o'
        end
        object lblNroDec: TLabel
          Left = 141
          Top = 11
          Width = 98
          Height = 14
          Caption = 'N'#250'mero de Decimais'
        end
        object lblForTot: TLabel
          Left = 16
          Top = 521
          Width = 120
          Height = 14
          Caption = 'F'#243'rmula para Totaliza'#231#227'o'
        end
        object lblAjudaFormula: TLabel
          Left = 806
          Top = 521
          Width = 177
          Height = 14
          Cursor = crHandPoint
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Ajuda sobre fun'#231#245'es da f'#243'rmula'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = lblAjudaFormulaClick
          ExplicitLeft = 816
        end
        object dbeNomCam: TDBEditFocus
          Left = 16
          Top = 24
          Width = 121
          Height = 22
          TabStop = False
          DataField = 'CAM_NOMCAM'
          DataSource = dtsCadCam
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNroDec: TDBEditFocus
          Left = 141
          Top = 25
          Width = 121
          Height = 22
          DataField = 'CAM_NRODEC'
          DataSource = dtsCadCam
          MaxLength = 1
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeFilPri: TDBCheckBox
          Left = 270
          Top = 7
          Width = 294
          Height = 17
          Caption = 'Utilizar mais de uma linha para o campo se necess'#225'rio'
          DataField = 'CAM_STRETC'
          DataSource = dtsCadCam
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeForTot: TDBMemoFocus
          Left = 16
          Top = 535
          Width = 977
          Height = 89
          DataField = 'CAM_FORTOT'
          DataSource = dtsCadCam
          ScrollBars = ssBoth
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object grbVisibilidade: TGroupBox
          Left = 16
          Top = 108
          Width = 977
          Height = 109
          Caption = 'Visibilidade'
          TabOrder = 8
          object Label4: TLabel
            Left = 13
            Top = 16
            Width = 149
            Height = 14
            Caption = 'Quando o campo estar'#225' vis'#237'vel'
          end
          object lblAprove: TLabel
            Left = 13
            Top = 61
            Width = 334
            Height = 14
            Caption = 'Campo que ter'#225' sua largura aumentada aproveitando o espa'#231'o vago '
          end
          object Label5: TLabel
            Left = 351
            Top = 16
            Width = 555
            Height = 14
            Caption = 
              'Express'#227'o que torna o campo vis'#237'vel (para configura'#231#245'es, favor u' +
              'tilizar o seguinte padr'#227'o: fCfgSis('#39'XXXXXX'#39') = '#39'X'#39
          end
          object dbeVisibi: TDBComboBoxFocus
            Left = 13
            Top = 30
            Width = 332
            Height = 22
            Style = csDropDownList
            DataField = 'CAM_VISIBI'
            DataSource = dtsCadCam
            Items.Strings = (
              'Sempre')
            TabOrder = 0
            OnChange = dbeVisibiChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeAprove: TDBLookupComboBox
            Left = 13
            Top = 75
            Width = 332
            Height = 22
            DataField = 'CAM_APROVE'
            DataSource = dtsCadCam
            KeyField = 'CAM_NOMCAM'
            ListField = 'CAM_NOMCAM'
            NullValueKey = 46
            TabOrder = 1
          end
          object dbeExpVis: TDBMemoFocus
            Left = 351
            Top = 30
            Width = 610
            Height = 67
            DataField = 'CAM_EXPVIS'
            DataSource = dtsCadCam
            ScrollBars = ssVertical
            TabOrder = 2
            OnExit = dbeExpVisExit
            OnKeyDown = dbeExpVisKeyDown
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
        object bdeNulBra: TDBCheckBox
          Left = 270
          Top = 24
          Width = 176
          Height = 17
          Caption = 'Deixar em branco quando nulo'
          DataField = 'CAM_NULBRA'
          DataSource = dtsCadCam
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object grbQuebra: TGroupBox
          Left = 16
          Top = 290
          Width = 977
          Height = 221
          Caption = 'Configura'#231#245'es da Quebra'
          TabOrder = 10
          object dbeQuebra: TDBCheckBox
            Left = 8
            Top = 18
            Width = 120
            Height = 18
            Caption = 'Quebrar pelo campo'
            DataField = 'CAM_QUEBRA'
            DataSource = dtsCadCam
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeQuebraClick
          end
          object dbeNewPag: TDBCheckBox
            AlignWithMargins = True
            Left = 271
            Top = 18
            Width = 177
            Height = 18
            Caption = 'Mudar de p'#225'gina a cada quebra'
            DataField = 'CAM_NEWPAG'
            DataSource = dtsCadCam
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeNewPagClick
          end
          object dbeReprin: TDBCheckBox
            Left = 130
            Top = 18
            Width = 141
            Height = 18
            Caption = 'Reimprimir a cada p'#225'gina'
            DataField = 'CAM_REPRIN'
            DataSource = dtsCadCam
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeQuebraClick
          end
          object pnlMsgDados: TPanel
            Left = 2
            Top = 115
            Width = 973
            Height = 104
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 8
            object Panel14: TPanel
              Left = 0
              Top = 0
              Width = 973
              Height = 25
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Mensagem de rodap'#233' da quebra'
              ParentColor = True
              TabOrder = 0
            end
            object dbeMsgGru: TDBMemoFocus
              Left = 0
              Top = 25
              Width = 973
              Height = 79
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              DataField = 'CAM_MSGGRU'
              DataSource = dtsCadCam
              ScrollBars = ssBoth
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
          end
          object Panel2: TPanel
            Left = 2
            Top = 49
            Width = 973
            Height = 25
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'Express'#227'o para realizar a quebra'
            ParentColor = True
            TabOrder = 9
          end
          object dbeQuaQue: TDBMemoFocus
            Left = 2
            Top = 74
            Width = 973
            Height = 41
            Align = alBottom
            DataField = 'CAM_QUAQUE'
            DataSource = dtsCadCam
            ScrollBars = ssVertical
            TabOrder = 7
            OnExit = dbeExpVisExit
            OnKeyDown = dbeExpVisKeyDown
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object dbeStaPag: TDBCheckBox
            AlignWithMargins = True
            Left = 446
            Top = 18
            Width = 228
            Height = 18
            Caption = 'Reiniciar n'#250'mero da p'#225'gina a cada quebra'
            DataField = 'CAM_STAPAG'
            DataSource = dtsCadCam
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeStaPagClick
          end
          object dbeSEPARQ: TDBCheckBox
            AlignWithMargins = True
            Left = 683
            Top = 18
            Width = 138
            Height = 18
            Caption = 'Separar PDF por quebra'
            DataField = 'CAM_SEPARQ'
            DataSource = dtsCadCam
            TabOrder = 4
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeSEPARQClick
          end
          object dbeREATOT: TDBCheckBox
            AlignWithMargins = True
            Left = 825
            Top = 18
            Width = 138
            Height = 18
            Caption = 'Realizar a totaliza'#231#227'o'
            DataField = 'CAM_REATOT'
            DataSource = dtsCadCam
            TabOrder = 5
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeSEPARQClick
          end
          object dbeRemLin: TDBCheckBox
            Left = 8
            Top = 41
            Width = 163
            Height = 18
            Caption = 'Remover linha ap'#243's quebra'
            DataField = 'CAM_REMLIN'
            DataSource = dtsCadCam
            TabOrder = 6
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeQuebraClick
          end
          object dbeKeepTg: TDBCheckBox
            AlignWithMargins = True
            Left = 173
            Top = 41
            Width = 92
            Height = 18
            Caption = 'Manter junto'
            DataField = 'CAM_KEEPTG'
            DataSource = dtsCadCam
            TabOrder = 10
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dbeKeepCh: TDBCheckBox
            AlignWithMargins = True
            Left = 271
            Top = 42
            Width = 120
            Height = 18
            Caption = 'Manter junto Childs'
            DataField = 'CAM_KEEPCH'
            DataSource = dtsCadCam
            TabOrder = 11
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object dbeDesCam: TDBMemoFocus
          Left = 16
          Top = 62
          Width = 977
          Height = 43
          DataField = 'CAM_DESCAM'
          DataSource = dtsCadCam
          ScrollBars = ssVertical
          TabOrder = 7
          OnExit = dbeExpVisExit
          OnKeyDown = dbeExpVisKeyDown
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbeMAXFIT: TDBCheckBox
          Left = 270
          Top = 41
          Width = 302
          Height = 17
          Caption = 'Limitar a largura m'#225'xima da coluna para a gera'#231#227'o em Grid'
          DataField = 'CAM_MAXFIT'
          DataSource = dtsCadCam
          TabOrder = 5
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeAlinha: TDBRadioGroup
          Left = 578
          Top = 8
          Width = 207
          Height = 54
          Caption = 'Alinhamento Horizontal'
          Columns = 2
          DataField = 'CAM_ALINHA'
          DataSource = dtsCadCam
          Items.Strings = (
            'Autom'#225'tico'
            'Esquerda'
            'Centralizado'
            'Direita')
          TabOrder = 6
          Values.Strings = (
            'A'
            'E'
            'C'
            'D')
        end
        object grbFonte: TGroupBox
          Left = 16
          Top = 221
          Width = 977
          Height = 63
          Caption = 'Altera'#231#227'o de fonte padr'#227'o do campo'
          TabOrder = 9
          object Label6: TLabel
            Left = 13
            Top = 17
            Width = 162
            Height = 14
            Caption = 'Condi'#231#227'o sobre o valor do campo'
          end
          object Label7: TLabel
            Left = 211
            Top = 17
            Width = 27
            Height = 14
            Caption = 'Fonte'
          end
          object Label8: TLabel
            Left = 747
            Top = 17
            Width = 127
            Height = 14
            Caption = 'Campo que define a fonte:'
          end
          object dbeFntCam: TDBEditFocus
            Left = 211
            Top = 32
            Width = 474
            Height = 22
            TabStop = False
            DataField = 'CAM_FNTCAM'
            DataSource = dtsCadCam
            Enabled = False
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object btnSetaFonte: TBitBtnLocked
            Left = 687
            Top = 32
            Width = 26
            Height = 22
            Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
            Cancel = True
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
              5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
              DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
              DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnSetaFonteClick
          end
          object dbeFntCnd: TDBMemoFocus
            Left = 13
            Top = 32
            Width = 196
            Height = 22
            DataField = 'CAM_FNTCND'
            DataSource = dtsCadCam
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object btnLimpaFonte: TBitBtnLocked
            Left = 715
            Top = 32
            Width = 26
            Height = 22
            Hint = 'Clique aqui para limpar a fonte'
            Cancel = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000C40E0000C40E00000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
              FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
              66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
              56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
              5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
              5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
              F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
              FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
              FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = btnLimpaFonteClick
          end
          object dbeDefFon: TcxDBLookupComboBox
            Left = 747
            Top = 32
            DataBinding.DataField = 'CAM_DEFFON'
            DataBinding.DataSource = dtsCadCam
            Properties.ClearKey = 46
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'CAM_NOMCAM'
            Properties.ListColumns = <
              item
                FieldName = 'CAM_NOMCAM'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsCampoFonte
            TabOrder = 4
            Width = 214
          end
        end
        object bdeDesLin: TDBCheckBox
          Left = 444
          Top = 24
          Width = 94
          Height = 17
          Hint = 
            'Permite desenhar linha acima <<LINEUP>>, abaixo <<LINEDOWN>>, '#224' ' +
            'esquerda <<LINELEFT>> e/ou '#224' direita <<LINERIGHT>> na banda onde' +
            ' est'#225' o campo'
          Caption = 'Desenhar linha'
          DataField = 'CAM_DESLIN'
          DataSource = dtsCadCam
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBRadioGroup1: TDBRadioGroup
          Left = 790
          Top = 8
          Width = 207
          Height = 54
          Caption = 'Alinhamento Vertical'
          Columns = 2
          DataField = 'CAM_VALIGN'
          DataSource = dtsCadCam
          Items.Strings = (
            'Top'
            'Centro'
            'Rodap'#233)
          TabOrder = 12
          Values.Strings = (
            'T'
            'C'
            'R')
        end
      end
    end
    object tbsFormula: TTabSheet
      Caption = '&2 - F'#243'rmula'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 217
        Align = alTop
        Caption = 'pnlFormula'
        TabOrder = 0
        object Label3: TLabel
          Left = 20
          Top = 7
          Width = 36
          Height = 14
          Caption = 'Fun'#231#227'o'
        end
        object dbeFuncao: TDBComboBoxFocus
          Left = 20
          Top = 21
          Width = 457
          Height = 22
          Style = csDropDownList
          DataField = 'CAM_FUNCAO'
          DataSource = dtsCadCam
          TabOrder = 0
          OnChange = dbeFuncaoChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object pnlParametros: TPanel
          Left = 1
          Top = 55
          Width = 998
          Height = 161
          Align = alBottom
          BevelOuter = bvLowered
          TabOrder = 1
          object cxGrid1: TcxGrid
            Left = 1
            Top = 1
            Width = 996
            Height = 159
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxvParametros: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = '<Func'#227'o sem par'#226'metros>'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Styles.ContentEven = cxStyle1
              Bands = <
                item
                  Caption = 'Par'#226'metros da Fun'#231#227'o'
                  Width = 492
                end>
              object cxvParametrosNOMPAR: TcxGridDBBandedColumn
                Caption = 'Par'#226'metro'
                DataBinding.FieldName = 'NOMPAR'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 326
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxvParametrosVALPAR: TcxGridDBBandedColumn
                Caption = 'Valor do Par'#226'metro (Campo)'
                DataBinding.FieldName = 'VALPAR'
                PropertiesClassName = 'TcxComboBoxProperties'
                Properties.DropDownListStyle = lsFixedList
                HeaderAlignmentHorz = taCenter
                Width = 392
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
            end
            object cxgParametros: TcxGridLevel
              GridView = cxvParametros
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = '3 - Gr'#225'fico'
      ImageIndex = 2
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 622
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 0
        object pnlGraficoComum: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 65
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlGraficoComum'
          ShowCaption = False
          TabOrder = 0
          object Label10: TLabel
            Left = 9
            Top = 14
            Width = 66
            Height = 14
            Caption = 'Tipo de Dado:'
          end
          object cmbTipGra: TComboBoxFocus
            Tag = 99
            Left = 9
            Top = 28
            Width = 169
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnChange = cmbTipGraChange
            Items.Strings = (
              'N'#227'o utiliza'
              'S'#233'rie'
              'Legenda'
              'Drill Up')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlGrafico: TPanel
          Left = 0
          Top = 65
          Width = 1000
          Height = 64
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlGrafico'
          ShowCaption = False
          TabOrder = 1
          object lblValCor: TLabel
            Left = 9
            Top = 12
            Width = 63
            Height = 14
            Caption = 'Cor da S'#233'rie:'
          end
          object lblGroDis: TLabel
            Left = 184
            Top = 13
            Width = 147
            Height = 14
            Caption = 'Formata'#231#227'o da legenda grupo:'
          end
          object lblTipDia: TLabel
            Left = 337
            Top = 13
            Width = 77
            Height = 14
            Caption = 'Tipo de Gr'#225'fico:'
          end
          object dbeValCor: TcxDBColorComboBox
            Left = 9
            Top = 26
            DataBinding.DataField = 'CAM_VALCOR'
            DataBinding.DataSource = dtsCadCam
            Properties.AllowSelectColor = True
            Properties.ClearKey = 46
            Properties.ColorDialogShowFull = True
            Properties.ColorDialogType = cxcdtAdvanced
            Properties.CustomColors = <>
            TabOrder = 0
            Width = 169
          end
          object cmbGroDis: TComboBoxFocus
            Tag = 99
            Left = 184
            Top = 27
            Width = 147
            Height = 22
            Style = csDropDownList
            TabOrder = 1
            Items.Strings = (
              'Sem fomata'#231#227'o'
              'Nome abreviado do m'#234's')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmbTipDia: TComboBoxFocus
            Tag = 99
            Left = 337
            Top = 27
            Width = 169
            Height = 22
            Style = csDropDownList
            TabOrder = 2
            OnChange = cmbTipGraChange
            Items.Strings = (
              'Default'
              'Gr'#225'fico de Colunas'
              'Gr'#225'fico de Linha'
              'Gr'#225'fico de Barras'
              'Gr'#225'fico de Torta'
              'Gr'#225'fico de '#193'rea'
              'Gr'#225'fico de Colunas Emplilhado'
              'Gr'#225'fico de Barras Emplihado'
              'Gr'#225'fico de '#193'rea Emplihado')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
    end
    object tbsLegendas: TTabSheet
      Caption = '4 - Legendas'
      ImageIndex = 3
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 111
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'Panel5'
        ShowCaption = False
        TabOrder = 0
        object Label9: TLabel
          Left = 19
          Top = 11
          Width = 85
          Height = 14
          Caption = 'T'#237'tulo da Legenda'
        end
        object Label11: TLabel
          Left = 503
          Top = 11
          Width = 154
          Height = 14
          Caption = 'N'#250'mero de Colunas da Legenda'
        end
        object Label14: TLabel
          Left = 319
          Top = 56
          Width = 188
          Height = 14
          Caption = 'Legenda de Refer'#234'ncia para a posi'#231#227'o'
        end
        object dbeTitLeg: TDBEditFocus
          Tag = 99
          Left = 19
          Top = 25
          Width = 478
          Height = 22
          DataField = 'CAM_TITLEG'
          DataSource = dtsCadCam
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePosLeg: TDBRadioGroup
          Tag = 99
          Left = 19
          Top = 56
          Width = 294
          Height = 46
          Caption = 'Posi'#231#227'o em rela'#231#227'o ao grupo da legenda indicada ao lado'
          Columns = 2
          DataField = 'CAM_POSLEG'
          DataSource = dtsCadCam
          Items.Strings = (
            'Direita'
            'Abaixo')
          TabOrder = 1
          Values.Strings = (
            'D'
            'A')
        end
        object dbeColLeg: TDBEditFocus
          Left = 503
          Top = 25
          Width = 121
          Height = 22
          DataField = 'CAM_COLLEG'
          DataSource = dtsCadCam
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeLegRef: TDBLookupComboBox
          Left = 319
          Top = 70
          Width = 188
          Height = 22
          DataField = 'CAM_LEGREF'
          DataSource = dtsCadCam
          KeyField = 'CAM_NOMCAM'
          ListField = 'CAM_NOMCAM'
          NullValueKey = 46
          TabOrder = 3
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 111
        Width = 1000
        Height = 424
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'Panel6'
        ShowCaption = False
        TabOrder = 1
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 998
          Height = 80
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel7'
          ShowCaption = False
          TabOrder = 0
          object Label12: TLabel
            Left = 18
            Top = 9
            Width = 42
            Height = 14
            Caption = 'Legenda'
          end
          object Label13: TLabel
            Left = 452
            Top = 9
            Width = 73
            Height = 14
            Caption = 'Cor da legenda'
          end
          object edtLegenda: TEditFocus
            Left = 18
            Top = 23
            Width = 431
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object btnIncCom: TBitBtnLocked
            Left = 18
            Top = 51
            Width = 133
            Height = 22
            Caption = '&Inclui Legenda'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
              609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
              D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
              9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
              95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
              8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
              A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
              A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
              E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
              B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
              ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
              E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
              BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
              27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
              EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
              C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
              C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
              8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
              CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
              D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
              FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
              CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
              68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 1
            OnClick = btnIncComClick
          end
          object btnSetaCorLegenda: TcxColorComboBox
            Left = 452
            Top = 23
            Properties.AllowSelectColor = True
            Properties.ColorValueFormat = cxcvHexadecimal
            Properties.CustomColors = <>
            TabOrder = 2
            Width = 253
          end
        end
        object cxgLegendas: TcxGrid
          Left = 1
          Top = 81
          Width = 998
          Height = 301
          Align = alClient
          TabOrder = 1
          object cxvLegendas: TcxGridDBTableView
            OnKeyDown = cxvLegendasKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCellDblClick = cxvLegendasCellDblClick
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nenhuma legenda cadastrada>'
            OptionsView.GroupByBox = False
            object cxvLegendasColumn1: TcxGridDBColumn
              Caption = 'Legenda'
              DataBinding.FieldName = 'legenda'
              HeaderAlignmentHorz = taCenter
              Width = 426
            end
            object cxvLegendasColumn2: TcxGridDBColumn
              Caption = 'Cor da legenda'
              DataBinding.FieldName = 'cor'
              PropertiesClassName = 'TcxColorComboBoxProperties'
              Properties.ColorValueFormat = cxcvHexadecimal
              Properties.CustomColors = <>
              Properties.ImmediatePost = True
              HeaderAlignmentHorz = taCenter
              Width = 152
            end
          end
          object cxgLegendasLevel1: TcxGridLevel
            GridView = cxvLegendas
          end
        end
        object Panel21: TPanel
          Left = 1
          Top = 382
          Width = 998
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object btnDelCom: TBitBtnLocked
            Left = 7
            Top = 9
            Width = 119
            Height = 22
            Caption = 'Exclui Legenda'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
              6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
              00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
              00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
              DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
              006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
              16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
              20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
              6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
              00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
              00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
              E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 0
            OnClick = btnDelComClick
          end
        end
      end
    end
    object tbsCodBar: TTabSheet
      Caption = '5 - C'#243'digo de Barras'
      ImageIndex = 4
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 622
        Align = alClient
        Caption = 'Panel8'
        ShowCaption = False
        TabOrder = 0
        object Label15: TLabel
          AlignWithMargins = True
          Left = 19
          Top = 17
          Width = 123
          Height = 14
          Caption = 'Tipo de c'#243'digo de barras:'
        end
        object Label16: TLabel
          Left = 19
          Top = 83
          Width = 63
          Height = 14
          Caption = 'Largura (cm)'
        end
        object Label17: TLabel
          Left = 103
          Top = 83
          Width = 54
          Height = 14
          Caption = 'Altura (cm)'
        end
        object Label18: TLabel
          Left = 194
          Top = 135
          Width = 27
          Height = 14
          Caption = 'Fonte'
        end
        object Label19: TLabel
          Left = 19
          Top = 135
          Width = 68
          Height = 14
          Caption = 'Cor do Fundo:'
        end
        object Label20: TLabel
          Left = 189
          Top = 83
          Width = 61
          Height = 14
          Caption = 'Zoom (fator)'
        end
        object Label21: TLabel
          Left = 237
          Top = 18
          Width = 41
          Height = 14
          Caption = 'Posi'#231#227'o:'
        end
        object dbeCHKSUM: TDBCheckBox
          Left = 19
          Top = 62
          Width = 118
          Height = 15
          Caption = 'Calcular checksum'
          DataField = 'CAM_CHKSUM'
          DataSource = dtsCadCam
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object debFNTCAM2: TDBEditFocus
          Left = 194
          Top = 150
          Width = 474
          Height = 22
          TabStop = False
          DataField = 'CAM_FNTCAM'
          DataSource = dtsCadCam
          Enabled = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnSetaFonte2: TBitBtnLocked
          Left = 671
          Top = 150
          Width = 26
          Height = 22
          Hint = 'Clique aqui para abrir a janela de defini'#231#227'o de fonte'
          Cancel = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
            DDDDDDD5555555555DDDDDD0000000000DDDDDDDDDDDDDDDDDDDDDD505DDDDD0
            5DDDDDD500DDDD005DDDDDDD00555500DDDDDDDD50000005DDDDDDDDD00DD00D
            DDDDDDDDD00DD00DDDDDDDDDD505505DDDDDDDDDDD0000DDDDDDDDDDDD5005DD
            DDDDDDDDDDD00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = btnSetaFonteClick
        end
        object btnLimpaFonte2: TBitBtnLocked
          Left = 699
          Top = 150
          Width = 26
          Height = 22
          Hint = 'Clique aqui para limpar a fonte'
          Cancel = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000C40E0000C40E00000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A6000020400000206000002080000020A0000020C0000020E000004000000040
            20000040400000406000004080000040A0000040C0000040E000006000000060
            20000060400000606000006080000060A0000060C0000060E000008000000080
            20000080400000806000008080000080A0000080C0000080E00000A0000000A0
            200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
            200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
            200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
            20004000400040006000400080004000A0004000C0004000E000402000004020
            20004020400040206000402080004020A0004020C0004020E000404000004040
            20004040400040406000404080004040A0004040C0004040E000406000004060
            20004060400040606000406080004060A0004060C0004060E000408000004080
            20004080400040806000408080004080A0004080C0004080E00040A0000040A0
            200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
            200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
            200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
            20008000400080006000800080008000A0008000C0008000E000802000008020
            20008020400080206000802080008020A0008020C0008020E000804000008040
            20008040400080406000804080008040A0008040C0008040E000806000008060
            20008060400080606000806080008060A0008060C0008060E000808000008080
            20008080400080806000808080008080A0008080C0008080E00080A0000080A0
            200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
            200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
            200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
            2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
            2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
            2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
            2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
            2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
            2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
            2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDCFFDFDFDFDFDFDFDFDFDFDFDFDFDFD97
            66EFFDFDFDFDFDFDFDFDFDFDFDFD975EF65697FDFDFDFDFDFDFDFDFDFD975EF6
            56575F97FDFDFDFDFDFDFDFD975EF656575F5F5F9EFDFDFDFDFDFD8F66F65657
            5F5F5F9EF0E3FDFDFDFDFDFD0756575F5F5F9EF0E9F1E3FDFDFDFDFDFD5F5F5F
            5F9EF0E9E9E9F1E3FDFDFDFDFDFD5F5F9EF0E9E9E9E9E9F0DDFDFDFDFDFDFDA6
            F0E9E9E9E9E9E9E9FDFDFDFDFDFDFDFDE9E9E9E9E9E9E9FDFDFDFDFDFDFDFDFD
            FDE9E9E9E9E9FDFDFDFDFDFDFDFDFDFDFDFDE9F1E9FDFDFDFDFDFDFDFDFDFDFD
            FDFDFDE3FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = btnLimpaFonteClick
        end
        object dbeVALCOR2: TcxDBColorComboBox
          Left = 19
          Top = 149
          DataBinding.DataField = 'CAM_VALCOR'
          DataBinding.DataSource = dtsCadCam
          Properties.AllowSelectColor = True
          Properties.ClearKey = 46
          Properties.ColorDialogShowFull = True
          Properties.ColorDialogType = cxcdtAdvanced
          Properties.CustomColors = <>
          TabOrder = 9
          Width = 169
        end
        object DBCheckBox1: TDBCheckBox
          Left = 143
          Top = 62
          Width = 118
          Height = 15
          Caption = 'Mostrar texto'
          DataField = 'CAM_MOSTXT'
          DataSource = dtsCadCam
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeCAMBAR: TDBComboBoxFocus
          Left = 19
          Top = 32
          Width = 214
          Height = 22
          Style = csDropDownList
          DataField = 'CAM_CAMBAR'
          DataSource = dtsCadCam
          Items.Strings = (
            'Code_2_5_interleaved'
            'Code_2_5_industrial'
            'Code_2_5_matrix'
            'Code39'
            'Code39Extended'
            'Code128'
            'Code128A'
            'Code128B'
            'Code128C'
            'Code93'
            'Code93Extended'
            'CodeMSI'
            'CodePostNet'
            'CodeCodabar'
            'CodeEAN8'
            'CodeEAN13'
            'CodeUPC_A'
            'CodeUPC_E0'
            'CodeUPC_E1'
            'CodeUPC_Supp2'
            'CodeUPC_Supp5'
            'CodeEAN128A'
            'CodeEAN128B'
            'CodeEAN128C')
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object DBEditFocus1: TDBEditFocus
          Left = 19
          Top = 97
          Width = 78
          Height = 22
          DataField = 'CAM_LARGUR'
          DataSource = dtsCadCam
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus2: TDBEditFocus
          Left = 103
          Top = 97
          Width = 78
          Height = 22
          DataField = 'CAM_ALTURA'
          DataSource = dtsCadCam
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object DBEditFocus3: TDBEditFocus
          Left = 189
          Top = 97
          Width = 78
          Height = 22
          DataField = 'CAM_BARZOO'
          DataSource = dtsCadCam
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object cmbPosBar: TComboBoxFocus
          Tag = 99
          Left = 237
          Top = 32
          Width = 276
          Height = 22
          Style = csDropDownList
          TabOrder = 10
          OnChange = cmbTipGraChange
          Items.Strings = (
            ''
            'Canto superior direito apenas na primeira p'#225'gina'
            'Canto superior direito em todas as p'#225'ginas'
            'Canto superior esquerdo apenas na primeira p'#225'gina'
            'Canto superior esquerdo em todas as p'#225'ginas')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
    end
    object tbsImagem: TTabSheet
      Caption = '6 - Imagem'
      ImageIndex = 5
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 622
        Align = alClient
        Caption = 'Panel8'
        ShowCaption = False
        TabOrder = 0
        object lblAltImg: TLabel
          Left = 14
          Top = 32
          Width = 83
          Height = 14
          Caption = 'Altura da Imagem'
        end
        object dbeExbImg: TDBCheckBox
          Left = 14
          Top = 9
          Width = 323
          Height = 17
          Caption = 'Converter campo em PictureBox'
          DataField = 'CAM_EXBIMG'
          DataSource = dtsCadCam
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeAltImg: TDBEditFocus
          Left = 14
          Top = 46
          Width = 121
          Height = 22
          DataField = 'CAM_ALTIMG'
          DataSource = dtsCadCam
          MaxLength = 1
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsEditavel: TTabSheet
      Caption = '7 - Edi'#231#227'o da Grid'
      ImageIndex = 6
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 1000
        Height = 40
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'Panel10'
        ParentColor = True
        ShowCaption = False
        TabOrder = 0
        object dbeEDITAV: TDBCheckBox
          Left = 14
          Top = 9
          Width = 94
          Height = 24
          Caption = 'Campo Edit'#225'vel'
          DataField = 'CAM_EDITAV'
          DataSource = dtsCadCam
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object pnlValidacao: TPanel
        Left = 0
        Top = 80
        Width = 1000
        Height = 382
        Align = alClient
        BevelOuter = bvLowered
        Caption = 'pnlValidacao'
        ParentColor = True
        TabOrder = 1
        object Panel12: TPanel
          Left = 1
          Top = 1
          Width = 998
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Script de Valida'#231#227'o do Campo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          object btnAjuda: TBitBtnLocked
            Left = 113
            Top = 3
            Width = 100
            Height = 22
            Caption = 'Ajuda Script'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000800000010000000100000
              0008000000010000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
              0B60000000070000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
              27EA0000000E0000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
              30EC0000000D0000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
              1A51000000050000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000600000011000000140000
              000A000000020000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000670503AA999532EFF4528
              187A000000070000000100000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
              4AF724150D490000000800000002000000000000000000000000000000000000
              0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
              9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
              000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
              AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
              00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
              76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
              000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
              70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
              000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
              C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
              0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
              77E570533B9A17100A2500000002000000000000000000000000000000000000
              0000000000000000000000000000000000010000000100000002000000030000
              0002000000020000000100000000000000000000000000000000}
            ParentFont = False
            TabOrder = 0
            OnClick = btnAjudaClick
          end
          object btnCompila: TBitBtnLocked
            Left = 8
            Top = 3
            Width = 99
            Height = 22
            Caption = 'Compila'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000010000000200000001000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000040000000A00000009000000040000000100000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000003070615205743B9081510410000000F0000000700000003000000010000
              0000000000000000000000000000000000000000000000000000000000000000
              000003080616328466FF2F7E64FC1D4C3CA6050D0A300000000E000000060000
              0002000000010000000000000000000000000000000000000000000000000000
              00000308061635896AFF56C8A2FF46A57DFF318064F51942348F020605220000
              000C000000050000000200000000000000000000000000000000000000000000
              000003080616388E6FFF63CEACFF49C69EFF51C29BFF4BA680FF317E63EA1536
              2A77010202190000000B00000005000000010000000000000000000000000000
              0000030907163A9373FF70D4B4FF4EC9A2FF4EC9A2FF4EC9A2FF55BF97FF4DA7
              82FF2F7960DC1029215F00000010000000050000000100000000000000000000
              0000040907163D9978FF7CD8BCFF53CCA7FF53CCA7FF53CCA7FF53CCA7FF5CCF
              ACFF64C09DFF52A886FF2D715AC40916112B0000000100000000000000000000
              000004090716409E7EFF89DDC4FF58CFABFF59CFACFF6ED5B6FF85DCC1FF8ADD
              C4FF8ADDC4FF7AC7A9FF5BAD90FF16362C5B0000000000000000000000000000
              0000040A081642A483FF94E1CAFF66D4B4FF87DEC4FF8EE0C8FF8EE0C8FF86D2
              B7FF66B89AFF337E66C810292141000000000000000000000000000000000000
              0000040A081645A987FFA6E7D4FF8FE1C9FF91E2CBFF94DCC4FF74C2A5FF3B91
              75DD183B2F5A0001010200000000000000000000000000000000000000000000
              0000040A081648AE8CFFC0EFE2FFA2E6D1FF7CC9ADFF42A082ED204E40750204
              0307000000000000000000000000000000000000000000000000000000000000
              0000040A09144DB392FF8AD0B7FF48AC8CF72862508D050B0911000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000040B09114CB594FE317761A70915121F0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000020504070F231D3200000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            TabOrder = 1
            OnClick = btnCompilaClick
          end
        end
        object stmSCRVAL: TfsSyntaxMemo
          AlignWithMargins = True
          Left = 4
          Top = 29
          Width = 992
          Height = 349
          Cursor = crIBeam
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          TabStop = True
          BlockColor = clHighlight
          BlockFontColor = clHighlightText
          CommentAttr.Charset = DEFAULT_CHARSET
          CommentAttr.Color = clNavy
          CommentAttr.Height = -13
          CommentAttr.Name = 'Courier New'
          CommentAttr.Style = [fsItalic]
          KeywordAttr.Charset = DEFAULT_CHARSET
          KeywordAttr.Color = clWindowText
          KeywordAttr.Height = -13
          KeywordAttr.Name = 'Courier New'
          KeywordAttr.Style = [fsBold]
          StringAttr.Charset = DEFAULT_CHARSET
          StringAttr.Color = clNavy
          StringAttr.Height = -13
          StringAttr.Name = 'Courier New'
          StringAttr.Style = []
          TextAttr.Charset = DEFAULT_CHARSET
          TextAttr.Color = clWindowText
          TextAttr.Height = -13
          TextAttr.Name = 'Courier New'
          TextAttr.Style = []
          Lines.Strings = (
            '')
          ReadOnly = False
          SyntaxType = stPascal
          ShowFooter = True
          ShowGutter = True
          ExplicitLeft = 65
          ExplicitTop = -59
          ExplicitWidth = 994
          ExplicitHeight = 508
        end
      end
      object pnlMarcarTodos: TPanel
        Left = 0
        Top = 40
        Width = 1000
        Height = 40
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'pnlMarcarTodos'
        ShowCaption = False
        TabOrder = 2
        object Label22: TLabel
          Left = 154
          Top = 14
          Width = 73
          Height = 14
          Caption = 'Valor Marcado:'
        end
        object Label23: TLabel
          Left = 317
          Top = 14
          Width = 92
          Height = 14
          Caption = 'Valor Desmarcado:'
        end
        object dbeINTERF: TDBCheckBox
          Tag = 99
          Left = 14
          Top = 9
          Width = 134
          Height = 24
          Caption = 'Editar como CheckBox'
          DataField = 'CAM_INTERF'
          DataSource = dtsCadCam
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBCheckBox2: TDBCheckBox
          Tag = 99
          Left = 545
          Top = 9
          Width = 274
          Height = 24
          Caption = 'Incluir bot'#245'es "Marcar todos" e "Desmarcar todos"'
          DataField = 'CAM_MARCAR'
          DataSource = dtsCadCam
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeValChe: TDBEditFocus
          Tag = 99
          Left = 230
          Top = 9
          Width = 70
          Height = 22
          TabStop = False
          DataField = 'CAM_VALCHE'
          DataSource = dtsCadCam
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValUnc: TDBEditFocus
          Tag = 99
          Left = 415
          Top = 9
          Width = 89
          Height = 22
          TabStop = False
          DataField = 'CAM_VALUNC'
          DataSource = dtsCadCam
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 462
        Width = 1000
        Height = 160
        Align = alBottom
        BevelOuter = bvLowered
        Caption = 'Panel11'
        ShowCaption = False
        TabOrder = 3
        object Panel13: TPanel
          Left = 1
          Top = 1
          Width = 998
          Height = 48
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel13'
          ShowCaption = False
          TabOrder = 0
          object Label24: TLabel
            Left = 12
            Top = 20
            Width = 150
            Height = 14
            Caption = 'Selecione a consulta desejada:'
          end
          object cxlPesGri: TcxDBLookupComboBox
            Left = 166
            Top = 16
            DataBinding.DataField = 'CAM_PESGRI'
            DataBinding.DataSource = dtsCadCam
            Properties.ClearKey = 46
            Properties.DropDownListStyle = lsFixedList
            Properties.KeyFieldNames = 'codigo'
            Properties.ListColumns = <
              item
                FieldName = 'descricao'
              end>
            Properties.ListOptions.AnsiSort = True
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.ShowHeader = False
            Properties.OnChange = cxlPesGriPropertiesChange
            TabOrder = 0
            Width = 470
          end
        end
        object cxgParametrosConsulta: TcxGrid
          Left = 1
          Top = 49
          Width = 998
          Height = 110
          Align = alClient
          TabOrder = 1
          object cxvParametrosConsulta: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Consulta sem par'#226'metros>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            Styles.ContentEven = cxStyle1
            object cxvParametrosDESPAR: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NOMFIL'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 232
            end
            object cxvParametrosTIPATR: TcxGridDBColumn
              Caption = 'Tipo de Atribui'#231#227'o'
              DataBinding.FieldName = 'MAP_TIPPAR'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.Alignment.Horz = taCenter
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'TIPATR'
              Properties.ListColumns = <
                item
                  FieldName = 'DESATR'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              HeaderAlignmentHorz = taCenter
              Width = 108
            end
            object cxvParametrosVALORC: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'MAP_VALORC'
              HeaderAlignmentHorz = taCenter
              Width = 142
            end
            object cxvParametrosPARPAI: TcxGridDBColumn
              Caption = 'Par'#226'metro do Relat'#243'rio'
              DataBinding.FieldName = 'MAP_PARPAI'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.ClearKey = 46
              Properties.DropDownAutoSize = True
              Properties.DropDownListStyle = lsFixedList
              Properties.KeyFieldNames = 'PAR_NOMPAR'
              Properties.ListColumns = <
                item
                  Width = 80
                  FieldName = 'PAR_NOMPAR'
                end
                item
                  Width = 200
                  FieldName = 'PAR_DESPAR'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              HeaderAlignmentHorz = taCenter
              Width = 93
            end
            object cxvParametrosNOMCAM: TcxGridDBColumn
              Caption = 'Campo do Relat'#243'rio'
              DataBinding.FieldName = 'MAP_CAMPAI'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.ClearKey = 46
              Properties.DropDownAutoSize = True
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.KeyFieldNames = 'CAM_NOMCAM'
              Properties.ListColumns = <
                item
                  Width = 80
                  FieldName = 'CAM_NOMCAM'
                end
                item
                  Width = 200
                  FieldName = 'CAM_DESCAM'
                end>
              Properties.ListOptions.CaseInsensitive = True
              Properties.ListOptions.ShowHeader = False
              HeaderAlignmentHorz = taCenter
              Width = 140
            end
          end
          object cxgParametrosLevel1: TcxGridLevel
            GridView = cxvParametrosConsulta
          end
        end
      end
    end
    object tbsXML: TTabSheet
      Caption = '8 - Gera'#231#227'o de XML'
      ImageIndex = 7
      object Label25: TLabel
        Left = 11
        Top = 11
        Width = 223
        Height = 14
        Caption = 'Tag que agrupa os campos da linha de quebra'
      end
      object Label26: TLabel
        Left = 11
        Top = 59
        Width = 103
        Height = 14
        Caption = 'Tag anterior a quebra'
      end
      object Label27: TLabel
        Left = 11
        Top = 107
        Width = 149
        Height = 14
        Caption = 'Tag posterior a linha de quebra'
      end
      object DBEditFocus4: TDBEditFocus
        Tag = 99
        Left = 11
        Top = 25
        Width = 223
        Height = 22
        DataField = 'CAM_TAGLIN'
        DataSource = dtsCadCam
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus5: TDBEditFocus
        Tag = 99
        Left = 11
        Top = 73
        Width = 223
        Height = 22
        DataField = 'CAM_TAGANT'
        DataSource = dtsCadCam
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus6: TDBEditFocus
        Tag = 99
        Left = 11
        Top = 121
        Width = 223
        Height = 22
        DataField = 'CAM_TAGPOS'
        DataSource = dtsCadCam
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 440
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 448
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 352
    Top = 424
  end
  object dtsCadCam: TDataSource
    Left = 664
    Top = 424
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 152
    Top = 456
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object dtsCampoFonte: TDataSource
    Left = 540
    Top = 461
  end
  object frxAjuda: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45141.605599097200000000
    ReportOptions.LastChange = 45141.605599097200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 444
    Top = 453
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Rich1: TfrxRichView
        Align = baClient
        Width = 718.110700000000000000
        Height = 1046.929810000000000000
        AllowExpressions = False
        GapX = 2.000000000000000000
        GapY = 1.000000000000000000
        RichEdit = {
          7B5C727466315C616E73695C616E7369637067313235325C64656666305C6E6F
          7569636F6D7061745C6465666C616E67313034367B5C666F6E7474626C7B5C66
          305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A7B5C636F
          6C6F7274626C203B5C726564305C677265656E305C626C75653235353B5C7265
          64305C677265656E305C626C7565303B7D0D0A7B5C2A5C67656E657261746F72
          2052696368656432302031302E302E32303334387D5C766965776B696E64345C
          756331200D0A5C706172645C71635C625C66305C6673323020436F6D706C656D
          656E746F7320616469636F6E61646F7320616F2070617363616C736372697074
          207061726120612076616C6964615C2765375C2765336F206461206564695C27
          65375C2765336F20646120636F6C756D6120646F20677269645C7061720D0A0D
          0A5C706172645C7061720D0A31202D204F626A65746F735C7061720D0A5C6230
          20202020205C7061720D0A202020312E31202D205C6366315C62206364734461
          646F735C6366305C623020202854556E69436C69656E7444617461536574293A
          20636C69656E7420636F6E74656E646F206F73206461646F7320646F2072656C
          61745C27663372696F2E5C7061720D0A202020202020312E312E31202D204D5C
          276539746F646F7320646F206364734461646F733A205C7061720D0A20202020
          20202020312E312E312E31202D2046756E6374696F6E205C6366315C62204669
          656C6442794E616D655C6366305C6230202873747243616D706F3A2053747269
          6E67293A20544669656C643B5C7061720D0A5C7061720D0A5C622032202D2050
          726F6365647572657320652046756E6374696F6E735C7061720D0A5C7061720D
          0A5C623020202020322E3031202D2066756E6374696F6E205C6366315C622066
          5072696D6569726F546F74616C477269645C6366305C6230202873747243616D
          706F3A20537472696E67293A2056617269616E743B5C7061720D0A2020202020
          20202020205265746F726E61206F20746F74616C20646120717565627261206D
          61697320696E7465726E6120656D2072656C615C2765375C2765336F2061206C
          696E686120717565206573745C27653120656D206564695C2765375C2765336F
          2E5C7061720D0A5C7061720D0A202020322E3032202D2066756E6374696F6E20
          5C6366315C622066546F74616C476572616C477269645C6366305C6230202873
          747243616D706F3A20537472696E67293A2056617269616E743B5C7061720D0A
          202020202020202020205265746F726E61206F20746F74616C20676572616C20
          646F20636F6C756E61202273747243616D706F222E5C7061720D0A5C7061720D
          0A202020322E3033202D2066756E6374696F6E206643757272656E7454696D65
          3A20537472696E673B5C7061720D0A202020322E3034202D2066756E6374696F
          6E206643757272656E74446174653A20537472696E673B5C7061720D0A202020
          322E3035202D2066756E6374696F6E206643757272656E744461746554696D65
          3A20537472696E673B5C7061720D0A202020322E3036202D2066756E6374696F
          6E20664E6F773A20544461746554696D653B5C7061720D0A202020322E303720
          2D2066756E6374696F6E206649734E756D62657228436F6E7374207374724E75
          6D6265723A20537472696E67293A20426F6F6C65616E3B5C7061720D0A202020
          322E3038202D2066756E6374696F6E2066456D70747953747228737472537472
          696E67203A20537472696E673B20626C6E546972614361726163457370656369
          616C3A20426F6F6C65616E203D2046616C7365293A20426F6F6C65616E3B5C70
          61720D0A202020322E3039202D2066756E6374696F6E20665061644C28737472
          546578746F3A20537472696E673B20696E7454616D616E686F3A20496E746567
          65723B2073747243617261637465723A20537472696E67203D20272720272729
          3A20537472696E673B5C7061720D0A202020322E3130202D2066756E6374696F
          6E20665061645228737472546578746F3A20537472696E673B20696E7454616D
          616E686F3A20496E74656765723B2073747243617261637465723A2053747269
          6E67203D202727202727293A20537472696E673B5C7061720D0A202020322E31
          31202D2066756E6374696F6E20665061644328737472546578746F3A20537472
          696E673B20696E7454616D616E686F3A20496E74656765723B20737472436172
          61637465723A20537472696E67203D202727202727293A20537472696E673B5C
          7061720D0A202020322E3132202D2070726F63656475726520704D656E736167
          656D4F6B287374724D656E736167656D3A20737472696E67293B5C7061720D0A
          202020322E3133202D2066756E6374696F6E206650657267756E746128737472
          4D656E736167656D3A20537472696E67293A20426F6F6C65616E3B5C7061720D
          0A202020322E3134202D2066756E6374696F6E206643616D706F546162656C61
          2873747243616D706F3A20537472696E673B20737472546162656C613A205374
          72696E673B206172724B6579732C2061727256616C7565733A2041727261793B
          20626C6E53656D7072654C657242616E636F3A20426F6F6C65616E203D205472
          7565293A2056617269616E743B5C7061720D0A202020322E3135202D2066756E
          6374696F6E20664366675369732873747243616D4366673A20537472696E673B
          20737472436F64456D703A20537472696E67203D202727293A2056617269616E
          743B5C7061720D0A5C7061720D0A5C622033202D20566172695C276531766569
          735C7061720D0A5C7061720D0A5C623020202020332E31202D205C6366315C62
          20526573756C7456616C69646174655C6366305C6230203A20426F6F6C65616E
          3B5C7061720D0A202020202020202044657465726D696E61207365206F207661
          6C6F72206174726962755C276564646F205C27653020636F6C756E6120646F20
          67726964205C27653920765C2765316C69646F2E202020202020202020205C70
          61720D0A5C7061720D0A202020332E32202D205C6366315C62204E657756616C
          75655C6366305C6230203A2056617269616E743B5C7061720D0A202020202020
          2020436F6E745C2765396D206F2076616C6F7220646967697461646F206E6120
          636F6C756E6120646F206772696420717565206573745C27653120656D206564
          695C2765375C2765336F2028616E746573206465207365722061747275696275
          5C276564646F20616F20636C69656E74292E5C7061720D0A5C7061720D0A2020
          20332E33202D207374724C6F67696E5573756172696F4C6F6761646F3A205374
          72696E673B5C7061720D0A2020202020202020435C2766336469676F20646F20
          7573755C27653172696F206C6F6761646F2E5C7061720D0A205C7061720D0A20
          2020332E34202D2056535F737472436F64456D703A20537472696E673B5C7061
          720D0A2020202020202020456D707265736120636F7272656E74652E5C706172
          0D0A5C7061720D0A202020332E35202D2056535F446174653A2054446174653B
          5C7061720D0A20202020202020204461746120636F7272656E74652E5C706172
          0D0A5C62202020205C7061720D0A2A205C62305C6920417320696E666F726D61
          5C2765375C276635657320656D20617A756C20735C2765336F206173206D6169
          732072656C6576616E7465732070617261206F20636F6E746578746F20646F20
          76616C6964615C2765375C2765336F20646120636F6C756E615C6930202E5C70
          61720D0A5C7061720D0A5C622034202D204578656D706C6F2064652076616C69
          64615C2765375C2765336F206465206564695C2765375C2765336F2064652063
          616D706F20636F6E74656E646F206F206E5C2766616D65726F20646F206C6F74
          6520646F2070726F6475746F5C62305C7061720D0A5C7061720D0A20205C6366
          3220426567696E5C6366305C7061720D0A202020205C636631204E657756616C
          75655C63663020203A3D20557070657263617365285C636631204E657756616C
          75655C63663020293B5C7061720D0A5C7061720D0A202020205C636631205265
          73756C7456616C69646174655C63663020203A3D205C636631206643616D706F
          546162656C615C6366302028274C4F545F4E554D4C4F54272C20274341444C4F
          54272C205B274C4F545F434F44454D50272C20274C4F545F434F44495445272C
          20274C4F545F4E554D4C4F54275D2C5C7061720D0A2020202020202020202020
          5B5C636631206364734461646F732E4669656C6442794E616D655C6366302028
          27434F44454D5027292E4173537472696E672C205C636631206364734461646F
          732E4669656C6442794E616D655C636630202827434F4449544527292E417353
          7472696E672C205C636631204E657756616C75655C636630205D29203C3E2027
          273B5C7061720D0A5C7061720D0A202020204966204E6F74205C636631205265
          73756C7456616C69646174655C63663020205468656E5C7061720D0A20202020
          20205C63663120704D656E736167656D4F6B5C6366302028274C6F7465206E5C
          2765336F2065636F6E747261646F2127293B5C7061720D0A2020456E642E5C70
          61720D0A5C7061720D0A5C7061720D0A5C7061720D0A5C667331365C7061720D
          0A7D0D0A00}
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Rich2: TfrxRichView
        Align = baClient
        Width = 718.110700000000000000
        Height = 1046.929810000000000000
        GapX = 2.000000000000000000
        GapY = 1.000000000000000000
        RichEdit = {
          7B5C727466315C616E73695C616E7369637067313235325C64656666305C6E6F
          7569636F6D7061745C6465666C616E67313034367B5C666F6E7474626C7B5C66
          305C666E696C5C666368617273657430205461686F6D613B7D7D0D0A7B5C636F
          6C6F7274626C203B5C726564305C677265656E305C626C75653235353B5C7265
          643235355C677265656E305C626C7565303B7D0D0A7B5C2A5C67656E65726174
          6F722052696368656432302031302E302E32303334387D5C766965776B696E64
          345C756331200D0A5C706172645C66305C667331365C7061720D0A5C7061720D
          0A5C625C667332302035202D204578656D706C6F2064652076616C6964615C27
          65375C2765336F206465206564695C2765375C2765336F2064652063616D706F
          20646520746F74616C207472616E7366657269646F20646F2043442070617261
          20765C2765317269617320656D7072657361735C62305C667331365C7061720D
          0A5C7061720D0A5C66733230205661725C7061720D0A2020666C74546F54616C
          5472616E7366657269646F3A20446F75626C653B5C7061720D0A626567696E5C
          7061720D0A20205C63663120526573756C7456616C69646174655C6366302020
          3A3D20547275653B5C7061720D0A5C7061720D0A202049662028566172546F53
          7472285C636631204E657756616C75655C6366302029203D2027272920546865
          6E5C7061720D0A20202020457869743B5C7061720D0A5C7061720D0A20204966
          20285C636631204E657756616C75655C63663020203C203029205468656E5C70
          61720D0A2020426567696E5C7061720D0A202020205C63663120704D656E7361
          67656D6F6B5C6366302028275175616E746964616465207472616E7366657269
          6461206E5C2765336F20706F646520736572206E656761746976612127293B5C
          7061720D0A202020205C63663120526573756C7456616C69646174655C636630
          20203A3D2046616C73653B5C7061720D0A20202020457869743B5C7061720D0A
          2020456E643B5C7061720D0A5C7061720D0A20205C6366325C695C7B50656761
          206F20746F74616C20646173207175616E74696461646573207472616E736665
          726964617320646F2070726F6475746F20636F7272656E746520706172612074
          6F64617320617320656D7072657361735C7D5C7061720D0A5C6366305C693020
          2020496620566172546F537472285C63663120665072696D6569726F546F7461
          6C477269645C6366302028274E4543434F4D272929203C3E202727205468656E
          5C7061720D0A20202020666C74546F54616C5472616E7366657269646F203A3D
          205C63663120665072696D6569726F546F74616C477269645C6366302028274E
          4543434F4D27295C7061720D0A2020456C73655C7061720D0A20202020666C74
          546F54616C5472616E7366657269646F203A3D20303B5C7061720D0A5C706172
          0D0A20205C6366325C695C7B526563616C63756C61206F206E6F766F20746F74
          616C206120736572207472616E7366657269646F5C7D5C6366305C69305C7061
          720D0A2020666C74546F54616C5472616E7366657269646F203A3D20666C7454
          6F54616C5472616E7366657269646F202D205C636631206364734461646F732E
          4669656C6442794E616D655C6366302028274E4543434F4D27292E4173466C6F
          6174202B205C636631204E657756616C75655C636630203B5C7061720D0A5C70
          61720D0A20205C6366325C695C7B56616C696461206573746F717565206D5C27
          65646E696D6F20646F2043445C7D5C7061720D0A5C6366305C69302020204966
          205C636631206364734461646F732E4669656C6442794E616D655C6366302028
          2753414C44434427292E4173466C6F6174202D20666C74546F54616C5472616E
          7366657269646F203C205C636631206364734461646F732E4669656C6442794E
          616D655C6366302028274553544D494E434427292E4173466C6F617420546865
          6E5C7061720D0A2020426567696E5C7061720D0A202020205C63663120704D65
          6E736167656D6F6B5C6366302028275175616E74696461646520646569786172
          5C276531206F2073616C646F20646F2043442061626169786F20646F204D5C27
          65646E696D6F2127293B5C7061720D0A202020205C63663120526573756C7456
          616C69646174655C63663020203A3D2046616C73653B5C7061720D0A2020456E
          645C7061720D0A5C7061720D0A20205C6366325C695C7B56616C696461207361
          6C646F20646973706F6E5C27656476656C20646F2043445C7D5C6366305C6930
          5C7061720D0A2020456C736520496620666C74546F54616C5472616E73666572
          69646F203E205C636631206364734461646F732E4669656C6442794E616D655C
          63663020282753414C44434427292E4173466C6F6174205468656E5C7061720D
          0A2020426567696E5C7061720D0A202020205C63663120526573756C7456616C
          69646174655C63663020203A3D2046616C73653B5C7061720D0A202020205C63
          663120704D656E736167656D6F6B5C6366302028275175616E74696461646520
          657863656465206F20646973706F6E5C27656476656C206E6F2043442127293B
          5C7061720D0A2020456E643B5C7061720D0A5C7061720D0A456E642E5C706172
          0D0A7D0D0A00}
      end
    end
  end
end
