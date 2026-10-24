unit untConsultasEtiqueta;

interface

Uses
  Uni, SysUtils, Forms, StdCtrls, EditFocus, MaskEditFocus, untTypesSistema,
  untClassPanelCx, untFuncoesSimples, Variants, UniClientDataSet, DB, Dialogs,
  StrUtils, DBEditFocus, ExtCtrls, cxStyles, Graphics, cxCustomData, System.Generics.Collections,
  Controls, Classes, untICadastros, Windows, BitBtnLockedIncrem;

  function fPesqConfiguracaoRel(opcTipCfg: TTipoConsultaSimples;
                                Self     : TForm;                       {* Formulário                                  *}
                                edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                                qryTabela: TUniQuery;                     {* Query                                       *}
                                Var chrKey: Char;                       {* Key                                         *}
                                Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                strWhere : String;                      {* Where                                       *}
                                blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                strTitulo: String = 'Configuração de Relatórios'): Boolean;

implementation

{*****************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA CFGREL *}
{**************************************************JU*}
function fPesqConfiguracaoRel(opcTipCfg: TTipoConsultaSimples;
                              Self     : TForm;                       {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                              qryTabela: TUniQuery;                     {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                              strWhere : String;                      {* Where                                       *}
                              blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                              strTitulo: String = 'Configuração de Relatórios'): Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      SetLength(arrTitCol, 0);

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   REL_NOMPRO, '; pAddNomeColuna('Nome do Programa');
      strSQL := strSQL + '   REL_DESPRO, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '   REL_NOMFIL, '; pAddNomeColuna('Nome da Fila');
      strSQL := strSQL + '   REL_IDEIMP, '; pAddNomeColuna('Tipo de Impressão');
      strSQL := strSQL + '   REL_PERGUN, '; pAddNomeColuna('Pergunta Tipo de Impressão');
      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + ' FROM CFGREL ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      if fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['REL_DESPRO','REL_NOMPRO'],
                   '',
                   'CFGREL',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'REL_NOMPRO',
                   Nil) then
      begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('REL_NOMPRO').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('REL_NOMPRO').AsString;
          End;

          If Assigned(edtDesPor) Then
            edtDesPor.Text := qryConsulta.FieldByName('REL_DESPRO').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDesPor) Then
              edtDesPor.Text := '+1';

          End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      end;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    end;
  End;
end;

end.
