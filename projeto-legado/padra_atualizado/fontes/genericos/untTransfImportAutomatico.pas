(* pAddEditInput: Os edits adicionados nesta lista devem ser na ordem do excel}
                              -----------------------------------------------------------------------------------------------
                  Ex:         | Codigo | Valor Codigo | Informacao A | Valor Informação A | Informacao b | Valor Informação |
                              -----------------------------------------------------------------------------------------------
                   Pos. Excel |   A1   |      A2      |       A3     |       A4           |    A5        |        A6        |
                              -----------------------------------------------------------------------------------------------

                   Logo os posicionamentos dos edits serão
                   1º - Codigo
                   2º - Informacao a
                   3º - Informacao b ... e assim por diante
                   Ou seja a posição do campo do excel é referente tambem à posição do edit no array criado
  FobjLogExterno:  Este objeto só estara Assigned no momento da execução*)


unit untTransfImportAutomatico;

interface

uses cxProgressBar, Windows, Messages, SysUtils, Variants, Classes, untExcel, Dialogs, StdCtrls, Forms, Controls;

Type
  TExecTransf = TNotifyEvent;

  TListaCampos = record
    objEditInput: TEdit;
    intQtdChar : integer;
    blnNotNull: Boolean;
    blnLinhaGrupo: Boolean;
  End;

  TTransfImportAutomatico = Class
  Private
    ArrayCampos:  Array of TListaCampos;
    OpenDialog: TOpenDialog;
    FintQuantidadeRegistros: Integer;
    FobjLogExterno         : TStringList;
    Excel                  : TExcel;
    frmlog: TForm;
    FblnExecutandoTransferencia: Boolean;
    function  fCarregarExcel: boolean;
    function  fExecutarProcesso(pgbProgresso: TcxProgressBar): Boolean;
    function fTratarTexto(intCompletaZero: Integer; blnLinhaGrupo: boolean; Text: String): string;
    procedure pShowLog;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Public

    blnErro: Boolean;
    blnErroParcial: Boolean;

    pEventoQueTransfere: TExecTransf;
    function  fExecutar: Boolean;
    procedure pAddEditInput(Edit: TEdit; intQtdZeroEsquerda: Integer = 0; blnNotNull: Boolean = False; blnLinhaGrupo: Boolean = False);
    procedure pAddNotificacao(Text: String);
    Destructor  Destroy; override;
    constructor Create;
    property blnExecutandoTransferencia: Boolean Read FblnExecutandoTransferencia;
End;

implementation

uses untFuncoesSimples, untGravando;

{ TTransfImportAutomatico }

constructor TTransfImportAutomatico.Create;
begin
  OpenDialog := TOpenDialog.Create(Nil);
  FobjLogExterno := TStringList.Create;
  OpenDialog.Filter := '*.xls; *.xlsx; *.csv';
  Excel := TExcel.fCriarExcel(Nil);
  FblnExecutandoTransferencia := False;

  blnErro := False;
  blnErroParcial := False;
end;

destructor TTransfImportAutomatico.Destroy;
begin
  SetLength(ArrayCampos, 0);
  FreeAndNil(FobjLogExterno);
  FreeAndNil(OpenDialog);
  FreeAndNil(Excel);
end;

procedure TTransfImportAutomatico.pAddEditInput(Edit: TEdit; intQtdZeroEsquerda: Integer = 0; blnNotNull: Boolean = False; blnLinhaGrupo: Boolean = False);
  var intPos: Integer;
begin
  If Assigned(Edit) Then
  Begin
    intPos := Length(ArrayCampos);
    SetLength(ArrayCampos,  intPos + 1);
    ArrayCampos[intPos].objEditInput := Edit;
    ArrayCampos[intPos].intQtdChar   := intQtdZeroEsquerda;
    ArrayCampos[intPOs].blnNotNull   := blnNotNull;
    ArrayCampos[intPOs].blnLinhaGrupo:= blnLinhaGrupo;
  End;
end;

procedure TTransfImportAutomatico.pAddNotificacao(Text: String);
begin
  If FblnExecutandoTransferencia Then
  Begin
    FobjLogExterno.Add('Excel linha : ' + IntToStr(Excel.LinhaAtual));
    FobjLogExterno.Add(Text);
    FobjLogExterno.Add('');

    blnErro := True;

  End Else
    fMensagem('', Text, ['&Ok']);
end;

procedure TTransfImportAutomatico.pShowLog;
var objMemo: TMemo;
begin
  If FobjLogExterno.Count <> -1  Then
  Begin
    pCriarFormularios(TForm, frmLog);
    Try
      frmlog.BorderStyle := bsToolWindow;
      frmlog.ClientWidth := 500;
      frmlog.ClientHeight := 500;
      frmLog.Position := poScreenCenter;
      frmLog.Caption := 'Log';
      frmLog.KeyPreview := True;
      frmLog.OnKeyDown := FormKeyDown;

      objMemo := TMemo.Create(frmlog);
      objMemo.Parent := frmlog;
      objMemo.Font.Name := 'Console';
      objMemo.Font.Size := 8;
      objMemo.ReadOnly := True;
      objMemo.Align := alClient;
      objMemo.Lines.Add(FobjLogExterno.Text);
      objMemo.Scrollbars := ssBoth;

      frmlog.ShowModal;
      FobjLogExterno.Clear;

    Finally
      FreeAndNil(objMemo);
      FreeAndNil(frmLog);
    End;
  End;
end;

function TTransfImportAutomatico.fExecutar: Boolean;
begin
  Result := False;
  Try

    If Not fCarregarExcel Then
    begin
      pMensagemOk('Não foi selecionado uma planilha!');
      Exit;
    End;

    If Not Assigned(pEventoQueTransfere) Then
       Exception.Create('pEventoQueTransfere não foi definido para a importação automática. ' +
                        'Impossível realizar o processo nesta transferência de código. ' +
                        'Informar a CITEL.');
    If Length(ArrayCampos) = 0 Then
       Exception.Create('ArrayCampos não foi definido para a importação automática. ' +
                        'Impossível realizar o processo nesta transferência de código. ' +
                        'Informar a CITEL.');

    { Inicia a importação e leitura do arquivo }
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.fExecutarAcao := fExecutarProcesso;
      frmGravando.lblGravando.Caption := 'Processando Excel...';
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;

      If blnErro Then
        pShowLog
      Else
        pMensagemOk('Operação realizada com sucesso!');

    Finally
      FreeAndNil(frmGravando);
    End;
    SetLength(ArrayCampos, 0);
  Except
    on E: Exception do
      pMensagensErro(E.message, '[TTransfImportAutomatico.fExecutar]');
  End
end;

function TTransfImportAutomatico.fExecutarProcesso(pgbProgresso: TcxProgressBar): Boolean;
  var
    intCol: integer;
    blnInformacaoEncontrada: Boolean;
    blnFaltaInformacao: Boolean;
begin
  Result := True;
  FblnExecutandoTransferencia := True;
  pgbProgresso.Properties.Max := FintQuantidadeRegistros;
  Excel.LinhaAtual := 1;

  pgbProgresso.Position := pgbProgresso.Position + 1;

  blnErro := False;

  Try
    While Not (Excel.LinhaAtual > FintQuantidadeRegistros ) Do
    Begin
      blnErroParcial := False;

      //Variavel de controle de campos que tem que ser preenchido
      blnFaltaInformacao := False;

      For intCol := 0 To Length(ArrayCampos) -1  Do
      Begin
        Excel.ColunaAtual := intCol + 1;
        // Conforme anotaçãoes acima o edit que recebe o text conforme a ordem da coluna;
        ArrayCampos[intCol].objEditInput.Text := Trim(fRetSomenteNumeros(Excel.Ler_Celula(fGetLetraAlfa(intCol + 1) + IntToStr(Excel.LinhaAtual))));
        //Verifica se tem conteudo dentro da celula
        blnInformacaoEncontrada := Not (fEmptyStr(ArrayCampos[intCol].objEditInput.Text));
        //Se não tiver informação e o campo for obrigatorio Retorna que a celula esta em branco
        If (Not (blnInformacaoEncontrada)) And (ArrayCampos[intCol].blnNotNull) Then
        Begin
          blnFaltaInformacao := True;
          Break;
        End;

        //Se tiver conteudo escreve
        If (blnInformacaoEncontrada) Then
          ArrayCampos[intCol].objEditInput.Text := fTratarTexto(ArrayCampos[intCol].intQtdChar,
                                                                ArrayCampos[intCol].blnLinhaGrupo,
                                                                ArrayCampos[intCol].objEditInput.Text);


      End;

      If blnFaltaInformacao Then
      Begin
        FobjLogExterno.Add('Excel linha : ' + IntToStr(Excel.LinhaAtual));
        FobjLogExterno.Add('Posição [' + fGetLetraAlfa(intCol + 1) + ':' + IntToStr(Excel.LinhaAtual) + '] em branco');
        FobjLogExterno.Add('');

        blnErroParcial := True;
      End Else
      Begin
        pEventoQueTransfere(Self);
      End;

      If blnErroParcial Then
        blnErro := True;

      Excel.Escrever(Excel.LinhaAtual, Length(ArrayCampos) + 1, 'PROCESSADO');

      pgbProgresso.Position := pgbProgresso.Position + 1;
      frmGravando.lblGravando.Caption := 'Processando Excel: ' + pgbProgresso.Position.ToString + '/' + pgbProgresso.Properties.Max.ToString + '...';
      Application.ProcessMessages;

      Excel.ProximaLinha;
    End;
  Except
    on e:Exception do
    Begin
      Result := False;

      blnErro := True;

      Excel.Escrever(Excel.LinhaAtual, Length(ArrayCampos) + 1, 'PROCESSADO_COM_ERRO');

      FobjLogExterno.Add('Excel linha : ' + IntToStr(Excel.LinhaAtual));
      FobjLogExterno.Add(e.Message + ' - [TTransfImportAutomatico.fExecutarProcesso]');
      FobjLogExterno.Add('');
    End;
  End;
  FblnExecutandoTransferencia := False;
  Excel.FecharArquivo;
end;

procedure TTransfImportAutomatico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Escape Then
    frmLog.Close;
end;

function TTransfImportAutomatico.fTratarTexto(intCompletaZero: Integer; blnLinhaGrupo: boolean; Text: String): string;
var
  posPonto: integer;
begin
  Result := '';
  If blnLinhaGrupo Then
  Begin
    posPonto := pos('.', Text);

    If posPonto = 0 Then
    Begin
      If Length(Text) < 6 Then
        Text := fPadR(Text, 6, '0');
      insert('.',text, 4);
      posPonto := 4;
    End;
    Result := fPadL(Copy(Text, 0 , posPonto -1), 3, '0') + '.' + FPadR(Copy(Text, PosPonto + 1), 3, '0')
  End
  Else
    Result := fStrZero(Text, intCompletaZero);
end;

function TTransfImportAutomatico.fCarregarExcel: Boolean;
Begin
  Result := OpenDialog.Execute;
  If Result Then
    If Excel.AbrirArquivo(OpenDialog.FileName) Then
    Begin
      FintQuantidadeRegistros := Excel.MaximodeLinhas;
      Result := True;
    End;
End;

end.


